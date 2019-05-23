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

#ifndef DSPSYSTEM_H
#define DSPSYSTEM_H

#include "processor.h"
#include "controlvolume.h"
#include "doscillator.h"
#include "constants.h"
#include "string.h"
#include "utils.h"

class dspSystem : public processor {
public:
  /**
   * Constructor
   */
  dspSystem();

  /**
   * Destructor
   */
  ~dspSystem();

  /**
   * Initialization function for the current filter plan
   */
  virtual bool init(const int frameRate,const int bufferSize);

  /**
   * Processing function
   */
  virtual bool process(float* in,float* out);

  /**
   * Shutdown the processor
   */
  virtual bool shutdown();

  /**
   * Set buffer size
   */
  virtual int setBufferSize(const int bufferSize);

  /**
   * Set frame rate
   */
  virtual int setSampleRate(const int sampleRate);

  /*
   * Updates volume for the system
   */


  void updateVolume(int value);


  void makeSound();

  void setFrequencies(const float tonef1, const float tonef2);


  // Sets directly to oscillator
  void setToneActive(bool toneActive);
  bool getToneActive();

  void setUChain(std::string uChain);
  std::string getUChain();

  void setPChain(int p);
  int getPChain();

  void setK(int k);
  int getK();

  void setChainActive(bool chainActive);
  bool getChainActive();

  void setChainFlank(bool chainFlank);
  bool getChainFlank();


protected:

  /**
   * Sample rate
   */
  int sampleRate_;

  /**
   * Buffer size
   */
  int bufferSize_;

  /**
   * VolumeGain
   */

  int volumeGain_;


  /**
   * control Volume
   */
  controlVolume* cv_;


  /**
   * Oscilator variables
   */

  doscillator* osc_;
  
  std::string uChain_;
  int p_;
  int k_;
  bool chainActive_, chainFlank_;

};


#endif // DSPSYSTEM_H
