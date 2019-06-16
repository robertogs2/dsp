/*
 * DSP Example is part of the DSP Lecture at TEC-Costa Rica
 * Copyright (C) 2010  Pablo Alvarado
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * \file   dspsystem.cpp
 *         Implements filtering in the frequency domain
 * \author Pablo Alvarado/Jose Miguel Barboza
 * \date   2010.12.12/2017.05.26
 *
 * $Id: equalizer.cpp $
 */

#include "dspsystem.h"
#include <cstring>

#undef _DSP_DEBUG
#define _DSP_DEBUG

#ifdef _DSP_DEBUG
#define _debug(x) std::cerr << x
#include <iostream>
#else
#define _debug(x)
#endif


dspSystem::dspSystem()
  :sampleRate_(0),bufferSize_(0),cv_(0),osc_(0){
}

dspSystem::~dspSystem() {
    delete cv_;
    delete osc_;
}


void dspSystem::updateVolume(int value){
    /*
    * Updating volume value
    */
    volumeGain_=value;
    //osc_->setFrequency(volumeGain_*constants::slope+constants::minFrequency); // Linear frequency changing
}

/**
 * Initialization function for the current filter plan
 */
bool dspSystem::init(const int sampleRate,const int bufferSize) {
  _debug("dspSystem::init()" << std::endl);

  sampleRate_ = sampleRate;
  bufferSize_ = bufferSize;

  volumeGain_ = 0;

  // Volume
  delete cv_;
  cv_=new controlVolume();

  // Oscillator
  delete osc_;
  osc_ = new doscillator();
  osc_->init(sampleRate_, bufferSize_, 1, 0, 1, 0);
  osc_->setActive(false);

  //System
  hanging_=false;
  chainActive_ = false;

  initFilters();

  return true;
}



void dspSystem::chainSound(float* tmpOut, float* fsig){
    int i = 0;
    bool trigger = false;
    for(; i < bufferSize_; ++i){
      // Triggering code
      trigger = k_ == constants::limit40;
      if(trigger){ // Happens once every time there is a change
        chainFlank_ = !chainFlank_;
        if(chainFlank_){
          osc_->setActive(true);
          p_++; // Increase index for processing
          if(p_ > uChain_.size()){ // Happens only when there is nothing more to process
            setChainActive(false);
            osc_->setActive(false);
            setUChain("");          //Resets the chain
            std::cout << "finish" << std::endl;
            //osc_->generateSignal();
            //fsig=osc_->getSignal();
            break;
          }
          // Updates frequencies for the oscillator
          float f1, f2;
          utils::getFrequency(uChain_[p_], f1, f2);
          osc_->setFrequency(f1, f2);
          osc_->generateSignal();
          fsig=osc_->getSignal();
        } // end if chain flank
        else{
          osc_->setActive(false);
          osc_->generateSignal();
        }
        k_=0;
      } // end if trigger
      k_++;
    } // end for
    tmpOut[i] = fsig[i]; //Here is the trick, it copies the value before it gets deleted
}

/**
 * Processing function
 */
bool dspSystem::process(float* in,float* out) {
    // Using time point and system_clock
    std::chrono::time_point<std::chrono::system_clock> start, end;
    start = std::chrono::system_clock::now();

    float* tmpIn = in;
    float* tmpOut = out;

    // Generates oscillation
    osc_->generateSignal();
    float* fsig=osc_->getSignal();

    if(chainActive_){//We need to reproduce a chain
    chainSound(tmpOut, fsig);
    } // end if chain

    //Copies the signal
    for(int i=0; i<bufferSize_;++i){
    tmpOut[i]=fsig[i];
    }
    //VectorOperations::printVector(tmpIn,bufferSize_);
    filter(tmpIn);

    // Signal with a oscilation
    cv_->filter(bufferSize_,volumeGain_,tmpOut,tmpOut);
    end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed_seconds = end - start;
    //std::cout << "elapsed time: " << elapsed_seconds.count() << "s\n";
    return true;
}


void dspSystem::initFilters(){
    _filterAmount = constants::filterAmount;
    _megafilters = new MegaFilter[_filterAmount];
    for(int i = 0; i < _filterAmount; ++i){
        _megafilters[i].init(constants::filterBuffers, bufferSize_);
    }

    //697Hz filter
    DoubleFilter* filter697 = new DoubleFilter(constants::sizeX1_697, constants::sizeY1_697, constants::sizeX2_697, constants::sizeY2_697, bufferSize_);
    filter697->setCoefficient(constants::coeffX1_697, constants::coeffY1_697, constants::coeffX2_697, constants::coeffY2_697, constants::gain1_697, constants::gain2_697);
    _megafilters[0]._filterUnit=filter697;
    _megafilters[0].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_697,constants::minimunHigh);

    //770Hz filter
    DoubleFilter* filter770 = new DoubleFilter(constants::sizeX1_770, constants::sizeY1_770, constants::sizeX2_770, constants::sizeY2_770, bufferSize_);
    filter770->setCoefficient(constants::coeffX1_770, constants::coeffY1_770, constants::coeffX2_770, constants::coeffY2_770, constants::gain1_770, constants::gain2_770);
    _megafilters[1]._filterUnit=filter770;
    _megafilters[1].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_770,constants::minimunHigh);

    //852Hz filter
    DoubleFilter* filter852 = new DoubleFilter(constants::sizeX1_852, constants::sizeY1_852, constants::sizeX2_852, constants::sizeY2_852, bufferSize_);
    filter852->setCoefficient(constants::coeffX1_852, constants::coeffY1_852, constants::coeffX2_852, constants::coeffY2_852, constants::gain1_852, constants::gain2_852);
    _megafilters[2]._filterUnit=filter852;
    _megafilters[2].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_852,constants::minimunHigh);

    //941Hz filter
    DoubleFilter* filter941 = new DoubleFilter(constants::sizeX1_941, constants::sizeY1_941, constants::sizeX2_941, constants::sizeY2_941, bufferSize_);
    filter941->setCoefficient(constants::coeffX1_941, constants::coeffY1_941, constants::coeffX2_941, constants::coeffY2_941, constants::gain1_941, constants::gain2_941);
    _megafilters[3]._filterUnit=filter941;
    _megafilters[3].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_941,constants::minimunHigh);

    //1209Hz filter
    DoubleFilter* filter1209 = new DoubleFilter(constants::sizeX1_1209, constants::sizeY1_1209, constants::sizeX2_1209, constants::sizeY2_1209, bufferSize_);
    filter1209->setCoefficient(constants::coeffX1_1209, constants::coeffY1_1209, constants::coeffX2_1209, constants::coeffY2_1209, constants::gain1_1209, constants::gain2_1209);
    _megafilters[4]._filterUnit=filter1209;
    _megafilters[4].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_1209,constants::minimunHigh);

    //1336Hz filter
    DoubleFilter* filter1336 = new DoubleFilter(constants::sizeX1_1336, constants::sizeY1_1336, constants::sizeX2_1336, constants::sizeY2_1336, bufferSize_);
    filter1336->setCoefficient(constants::coeffX1_1336, constants::coeffY1_1336, constants::coeffX2_1336, constants::coeffY2_1336, constants::gain1_1336, constants::gain2_1336);
    _megafilters[5]._filterUnit=filter1336;
    _megafilters[5].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_1336,constants::minimunHigh);

    //1477Hz filter
    DoubleFilter* filter1477 = new DoubleFilter(constants::sizeX1_1477, constants::sizeY1_1477, constants::sizeX2_1477, constants::sizeY2_1477, bufferSize_);
    filter1477->setCoefficient(constants::coeffX1_1477, constants::coeffY1_1477, constants::coeffX2_1477, constants::coeffY2_1477, constants::gain1_1477, constants::gain2_1477);
    _megafilters[6]._filterUnit=filter1477;
    _megafilters[6].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_1477,constants::minimunHigh);

    //1633Hz filter
    DoubleFilter* filter1633 = new DoubleFilter(constants::sizeX1_1633, constants::sizeY1_1633, constants::sizeX2_1633, constants::sizeY2_1633, bufferSize_);
    filter1633->setCoefficient(constants::coeffX1_1633, constants::coeffY1_1633, constants::coeffX2_1633, constants::coeffY2_1633, constants::gain1_1633, constants::gain2_1633);
    _megafilters[7]._filterUnit=filter1633;
    _megafilters[7].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_1633,constants::minimunHigh);

}

void dspSystem::filter(float *x){
    int limit = _filterAmount;
    static int iFound = -1;
    int jFound = -1;
    for(int i = 0; i < limit/2 ; ++i){
      _megafilters[i].filter(x);
      if(_megafilters[i].analyze()){
          iFound = i;
          //std::cout << "found at " << i << std::endl;
      }
    }
    for(int i = limit/2; i < limit ; ++i){
      _megafilters[i].filter(x);
      if(_megafilters[i].analyze()) {
          jFound = i;
          //std::cout << "found at " << i << std::endl;
      }
    }
    if(iFound != -1 && jFound != -1){
        char c = utils::getChar(iFound, jFound-4);
        std::cout << "FOUND: " << c << std::endl;
    }
    /*_megafilters[4].filter(x);
    if(_megafilters[4].analyze());*/
}

/**
 * Shutdown the processor
 */
bool dspSystem::shutdown() {
  return true;
}

/**
 * Set buffer size (call-back)
 */
int dspSystem::setBufferSize(const int bufferSize) {
  bufferSize_=bufferSize;
  return 1;
}

/**
 * Set sample rate (call-back)
 */
int dspSystem::setSampleRate(const int sampleRate) {
  sampleRate_=sampleRate;
  return 1;
}

void dspSystem::setFrequencies(const float tonef1, const float tonef2){
  osc_->setFrequency(tonef1, tonef2);
}

void dspSystem::setToneActive(bool toneActive){osc_->setActive(toneActive);}
bool dspSystem::getToneActive(){return osc_->getActive();}

void dspSystem::setUChain(std::string uChain){uChain_ = uChain;}
std::string dspSystem::getUChain(){return uChain_;}

void dspSystem::setPChain(int p){p_=p;}
int dspSystem::getPChain(){return p_;}

void dspSystem::setK(int k){k_=k;}
int dspSystem::getK(){return k_;}

void dspSystem::setChainActive(bool chainActive){chainActive_=chainActive;}
bool dspSystem::getChainActive(){return chainActive_;}

void dspSystem::setChainFlank(bool chainFlank){chainFlank_=chainFlank;}
bool dspSystem::getChainFlank(){return chainFlank_;}

void dspSystem::setHanging(bool hanging){hanging_=hanging;}
bool dspSystem::getHanging(){return hanging_;}

void dspSystem::addToChain(char c){
  uChain_ += c;
}
