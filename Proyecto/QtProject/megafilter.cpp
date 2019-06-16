#include "megafilter.h"

MegaFilter::MegaFilter(){

}

void MegaFilter::init(int buffers, int bufferSize){
    _buffers = buffers;
    _bufferSize = bufferSize;

    _filteredSignal = new float[_buffers*_bufferSize];
    _tempSignal1 = new float[_buffers*_bufferSize];
    _tempSignal2 = new float[_buffers*_bufferSize];
    _states;
}

void MegaFilter::setEmpiricalVariables(int movingAverageSamples, float digitalThreshold, int mininumHigh){
    _movingAverageSamples = movingAverageSamples;
    _digitalThreshold = digitalThreshold;
    _mininumHigh = mininumHigh;
}

void MegaFilter::filter(float* x){
    // Shift first to make space
    VectorOperations::shiftVector(_filteredSignal, _filteredSignal, _buffers*_bufferSize, _bufferSize);

    // Filter the signal to the pointer of the end
    //_filterUnit->filter(x, _filteredSignal+(_buffers-1)*_bufferSize);

    //float* y = new float[_bufferSize];

    _filterUnit->filter(x, _tempSignal1);
    // Remove older chunk, move and insert newest
    VectorOperations::shiftAndConcatenateVector(_filteredSignal, _filteredSignal, _tempSignal1, _buffers*_bufferSize, _bufferSize);
    //delete y;
}

bool MegaFilter::analyze(){
    VectorOperations::squareVector(_filteredSignal, _tempSignal1, _buffers*_bufferSize);
    int ones = VectorOperations::averageDigitalizeCounterVector(_tempSignal1, _bufferSize*_buffers, _movingAverageSamples, _digitalThreshold);
    std::cout << ones << std::endl;

    // Checks for a hit
    _states[1] = _states[2];
    _states[2] = ones >= _mininumHigh;
    bool hit = (_states[1] && _states[2]) && !_states[0]; // two consecutive, but not in the middle
    _states[0] = hit;
    return hit;
}
