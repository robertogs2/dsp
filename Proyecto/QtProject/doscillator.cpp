#include "doscillator.h"

doscillator::doscillator(){

}

void doscillator::init(const int sampleRate, const int bufferSize, const float amplitudeZero, 
    			const float frequencyZero, const float amplitudeOne, const float frequencyOne){
	updateVariables(sampleRate, bufferSize, amplitudeZero, frequencyZero, amplitudeOne, frequencyOne);
	active_=true;
	signal_ = new float[bufferSize_];
}

void doscillator::updateVariables(const int sampleRate, const int bufferSize,
								const float amplitudeZero, const float frequencyZero, 
								const float amplitudeOne, const float frequencyOne){
	sampleRate_ = sampleRate;
	bufferSize_ = bufferSize;
	amplitudeZero_ = amplitudeZero;
	amplitudeOne_ = amplitudeOne;
	frequencyZero_ = frequencyZero;
	frequencyOne_ = frequencyOne;
	calculateConstants();
}

void doscillator::calculateConstants(){
	wZero_  = 2*M_PI*frequencyZero_/float(sampleRate_);
	y1Zero_ =0;
	y2Zero_ =-amplitudeZero_*sin(wZero_);
	a1Zero_ =2*cos(wZero_);

	wOne_  = 2*M_PI*frequencyOne_/float(sampleRate_);
	y1One_ =0;
	y2One_ =-amplitudeOne_*sin(wOne_);
	a1One_ =2*cos(wOne_);
}

void oscillator::setSampleRate(const int sampleRate){
	sampleRate_=sampleRate;
	calculateConstants();
}

void oscillator::setBufferSize(const int bufferSize){
	bufferSize_=bufferSize;
	calculateConstants();
}

// b to choose between both
template<bool b>
void doscillator::setAmplitude(const float amplitude){
	b ? amplitudeZero_ = amplitude : amplitudeOne_ = amplitude;
	calculateConstants();
}

template<bool b>
void doscillator::setFrequency(const float frequency){
	b ? frequencyZero_ = frequency : frequencyOne_ = frequency;
	calculateConstants();
}

float* oscillator::getSignal(){
	return signal_;
}

void oscillator::setActive(bool active){
	active_=active;
}

bool oscillator::getActive(){
	return active_;
}


void oscillator::generateSignal(){
	float f0, f1;
	for(int i = 0; i < bufferSize_; ++i){
		f0 = active_ ? a1Zero_*y1Zero_-y2Zero_ : 0;
		y2Zero_=y1Zero_;
		y1Zero_=f0;

		f1 = active_ ? a1One_*y1One_-y2One_ : 0;
		y2One_=y1One_;
		y1One_=f1;

		signal_[i]=(f1+f0) >> 1; //Average between both for tghe signal
	}
}