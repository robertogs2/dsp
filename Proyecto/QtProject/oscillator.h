#ifndef OSCILLATOR_H
#define OSCILLATOR_H

#include <math.h>
#include <iostream>
class oscillator{

public:

    /**
     * Constructor
     */
    oscillator();

    /**
     * Destructor
     */
    ~oscillator();

    /**
     *  Initializer for current oscilator variables
     */

    void init(const int sampleRate, const int bufferSize, const float amplitude, const float frequency);

    /**
     * Calculates next batch of signal
     */

    void generateSignal();

    float* getSignal();


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
   * Amplitude
   */

  float amplitude_;

  /**
   * Frequency for signal
   */

  float frequency_;

  /**
   * Actual oscilation signal
   */

  float* signal_;



private:

  void calculateConstants();

  float w_;
  float a1_;
  float y1_; 
  float y2_;

};

#endif // OSCILLATOR_H