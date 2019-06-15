#ifndef DOUBLEFILTER_H
#define DOUBLEFILTER_H

#include "simplefilter.h"
class DoubleFilter
{
public:
    DoubleFilter();
    void filter(float* x, float* y);

    // Initialicing functions for the filters
    void setCoefficient(float* coeffX0, float* coeffX1, float* coeffY0, float* coeffY1);
    SimpleFilter* filter1;
    SimpleFilter* filter2;
};


#endif // DOUBLEFILTER_H
