#include "doublefilter.h"

DoubleFilter::DoubleFilter(int sizeX1, int sizeY1, int sizeX2, int sizeY2, int bufferSize){
    _bufferSize = bufferSize;
    _middleSignal = new float[bufferSize];
    filter1_ = new SimpleFilter(sizeX1, sizeY1, bufferSize);
    filter2_ = new SimpleFilter(sizeX2, sizeY2, bufferSize);
}

void DoubleFilter::filter(float *x, float *y){
    std::cout << "filtering one" << std::endl;
    filter1_->filter(x, _middleSignal);
    std::cout << "filtering two" << std::endl;
    filter2_->filter(_middleSignal, y);
}

void DoubleFilter::setCoefficient(const float *coeffX0, const float *coeffX1, const float *coeffY0, const float *coeffY1){
    filter1_->setCoefficients(coeffX0, coeffY0);
    filter2_->setCoefficients(coeffX1, coeffY1);
}
