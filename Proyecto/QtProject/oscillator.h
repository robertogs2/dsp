#ifndef OSCILLATOR_H
#define OSCILLATOR_H


class oscillator{

public:
    oscillator();
    void init(const int sampleRate, const int bufferSize);
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

  int amplitude_;

};

#endif // OSCILLATOR_H