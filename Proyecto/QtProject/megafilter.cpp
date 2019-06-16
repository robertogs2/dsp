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
    float* y = new float[_bufferSize];
    _filterUnit->filter(x, y);
    // Remove older chunk, move and insert newest
    VectorOperations::shiftAndConcatenateVector(_filteredSignal, _filteredSignal, y, _buffers*_bufferSize, _bufferSize);
    delete y;
}

bool MegaFilter::analyze(){
    VectorOperations::squareVector(_filteredSignal, _tempSignal1, _buffers*_bufferSize);

    VectorOperations::averageVector(_tempSignal1, _tempSignal2, _buffers*_bufferSize, _movingAverageSamples);
    VectorOperations::digitalizeVector(_tempSignal2, _tempSignal1, _buffers*_bufferSize, _digitalThreshold, 1);
    int amount = VectorOperations::countOnes(_tempSignal1, _buffers*_bufferSize);
    std::cout << amount << std::endl;
    //VectorOperations::printVector(_tempSignal1, _buffers*_bufferSize);
    // Analyze _tempSignal1 to check when it gets a hit
}
