#include "simplefilter.h"

SimpleFilter::SimpleFilter(int sizeX, int sizeY, int bufferSize){
    _sizeX = sizeX;
    _sizeY = sizeY;

    _coeffX = new float[sizeX];
    _lastX = new float[sizeX-1]; // Doesnt need to store current value

    _coeffY = new float[sizeY];
    _lastY = new float[sizeY];

    _bufferSize = bufferSize;
}

void SimpleFilter::setCoefficients(float* coeffX, float* coeffY){
    VectorOperations::copyVector(coeffX, _coeffX, _sizeX);
    VectorOperations::copyVector(coeffY, _coeffY, _sizeY);
}

void SimpleFilter::filter(float *x, float *y){
    for(int i = 0; i < _bufferSize; ++i){
        float sumY = 0;
        for(int j = 0; j < _sizeY; ++j){
            sumY += _lastY[j]*_coeffY[j];
        }
        float sumX = x[i]*_coeffX[0];
        for(int j = 1; j < _sizeX; ++j){
            sumX += _lastX[j]*_coeffX[j];
        }

        y[i] = sumY + sumX;
        VectorOperations::delayVector(_lastY, _lastY, 1, _sizeY);
        _lastY[0] = y[i];

        VectorOperations::delayVector(_lastX, _lastX, 1, _sizeX-1);
        _lastX[0] = x[i];
    }
}
