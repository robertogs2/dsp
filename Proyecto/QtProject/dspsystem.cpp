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
 * \file   freqFilter.h
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

  delete cv_;
  cv_=new controlVolume();

  delete osc_;
  osc_ = new doscillator();
  osc_->init(sampleRate_, bufferSize_, 1, 0, 1, 0);
  osc_->setActive(false);

  return true;
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
        }
        k_=0;
      } // end if trigger
      k_++;
    } // end for
    tmpOut[i] = fsig[i];
    
  }

  //Copies the signal
  for(int i=0; i<bufferSize_;++i){
    tmpOut[i]=fsig[i];
  }

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

void dspSystem::setToneActive(bool toneActive){
  osc_->setActive(toneActive);
}
bool dspSystem::getToneActive(){
  return osc_->getActive();
}

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
