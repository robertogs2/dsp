#ifndef DOUBLEFILTER_H
#define DOUBLEFILTER_H

#include "simplefilter.h"
class DoubleFilter
{
public:
    DoubleFilter(int sizeX1, int sizeY1, int sizeX2, int sizeY2, int bufferSize);
    void filter(float* x, float* y);

    // Initialicing functions for the filters
    void setCoefficient(const float* coeffX0, const float* coeffX1, const float* coeffY0, const float* coeffY1);
    SimpleFilter* filter1_;
    SimpleFilter* filter2_;
    int _bufferSize;
    float* _middleSignal;
};


#endif // DOUBLEFILTER_H
