#ifndef SIMPLEFILTER_H
#define SIMPLEFILTER_H

#include "vectoroperations.h"

class SimpleFilter{
public:
    SimpleFilter(int sizeX, int sizeY, bufferSize);
    void setCoefficients(float* coeffX, float* coeffY);
    void filter(float* x, float* y);

    int _bufferSize;
    int _sizeY; // Filter memory for Y
    int _sizeX; //Filter memory for X
    float* _coeffX; // Coefficients for X, counting 0
    float* _coeffY; // Coefficients for Y
    float* _lastX; // Last values for X
    float* _lastY; // Last values for Y
};

#endif // SIPLEFILTER_H
