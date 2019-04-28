#include "oscillator.h"

oscillator::oscillator():
	sampleRate_(0),
  	bufferSize_(0),
  	amplitude_(0),
  	frequency_(0){
}

oscillator::~oscillator(){
}

void oscillator::init(const int sampleRate, const int bufferSize, const float amplitude, const float frequency){
	sampleRate_ = sampleRate;
	bufferSize_ = bufferSize;
	amplitude_ = amplitude;
	frequency_ = frequency;
	signal_ = new float[bufferSize_];
	calculateConstants();
}

void oscillator::calculateConstants(){
	w_  = 2*M_PI*frequency_/float(sampleRate_);
	y1_ =0;
	y2_ =-amplitude_*sin(w_);
	std::cout << frequency_ << std::endl;
	std::cout << w_ << std::endl;
    std::cout << y2_ << std::endl;
	a1_ =2*cos(w_);
}

void oscillator::generateSignal(){
	for(int i = 0; i < bufferSize_; ++i){
		signal_[i]=a1_*y1_-y2_;
		y2_=y1_;
		y1_=signal_[i];
	}
}

float* oscillator::getSignal(){
	return signal_;
}
