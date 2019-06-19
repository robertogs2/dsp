#include "megafilter.h"

MegaFilter::MegaFilter(){

}

void MegaFilter::init(int buffers, int bufferSize){
    // Sets the initial variables
    _buffers = buffers;
    _bufferSize = bufferSize;


    // Creates vectors for signals
    _filteredSignal = new float[_buffers*_bufferSize];
    _tempSignal1 = new float[_buffers*_bufferSize];
    _tempSignal2 = new float[_buffers*_bufferSize];
}

void MegaFilter::setEmpiricalVariables(int movingAverageSamples, float digitalThreshold, int mininumHigh){
    // Sets empirical variables
    _movingAverageSamples = movingAverageSamples;
    _digitalThreshold = digitalThreshold;
    _mininumHigh = mininumHigh;
}

void MegaFilter::filter(float* x){
    // Filtes the signal
    _filterUnit->filter(x, _tempSignal1);
    // Remove older chunk, move and insert newest
    VectorOperations::shiftAndConcatenateVector(_filteredSignal, _filteredSignal, _tempSignal1, _buffers*_bufferSize, _bufferSize);
}

int MegaFilter::analyze(){
    // Square of the result signal
    VectorOperations::squareVector(_filteredSignal, _tempSignal1, _buffers*_bufferSize);

    // Takes the moving average and checks hoy many points are avoge a threshold
    int ones = VectorOperations::averageDigitalizeCounterVector(_tempSignal1, _bufferSize*_buffers, _movingAverageSamples, _digitalThreshold);

    // Checks for a hit
    bool hit = (ones > _mininumHigh) && !(_states[2]); // two consecutive not allowed

    // Stores older states
    _states[0] = _states[1];
    _states[1] = _states[2];
    _states[2] = hit;

    // Returns how hard is a hit
    return hit ? ones : 0;
}
