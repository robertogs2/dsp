#include "megafilter.h"

MegaFilter::MegaFilter(){

}

void MegaFilter::init(int buffers, int bufferSize){
    _buffers = buffers;
    _bufferSize = bufferSize;

    _filteredSignal = new float[_buffers*_bufferSize];
    _tempSignal1 = new float[_buffers*_bufferSize];
    _tempSignal2 = new float[_buffers*_bufferSize];
}

void MegaFilter::setEmpiricalVariables(int movingAverageSamples, float digitalThreshold, int mininumHigh){
    _movingAverageSamples = movingAverageSamples;
    _digitalThreshold = digitalThreshold;
    _mininumHigh = mininumHigh;
}

void MegaFilter::filter(float* x){

    _filterUnit->filter(x, _tempSignal1);
    // Remove older chunk, move and insert newest
    VectorOperations::shiftAndConcatenateVector(_filteredSignal, _filteredSignal, _tempSignal1, _buffers*_bufferSize, _bufferSize);
}

int MegaFilter::analyze(){
    VectorOperations::squareVector(_filteredSignal, _tempSignal1, _buffers*_bufferSize);
    int ones = VectorOperations::averageDigitalizeCounterVector(_tempSignal1, _bufferSize*_buffers, _movingAverageSamples, _digitalThreshold);

    //std::cout << VectorOperations::average(_tempSignal1, _buffers*_bufferSize) << std::endl;

    // Checks for a hit
    _states[1] = _states[2];
    _states[2] = ones;
    int average = (_states[1] + _states[2])/2;
    //std::cout << average << std::endl;
    bool hit = (average > _mininumHigh) && _states[0] != 1; // two consecutive not allowed
    _states[0] = hit;
    return hit*ones;
}
