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
    _megafilters[0].setEmpiricalVariables(constants::movingAverageSamples,constants::threshold_697,100);

}

void dspSystem::filter(float *x){
    //static int count  = 0;
    int limit = 1; // _filterAmount, need to fix
    //if(count++ < 10000000000){
        for(int i = 0; i < limit ; ++i){
            _megafilters[i].filter(x);
            _megafilters[i].analyze();
        }
    //}


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

  return true;
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
