#ifndef DOUBLEFILTER_H
#define DOUBLEFILTER_H

#include "simplefilter.h"
class DoubleFilter
{
public:
    DoubleFilter();
    void filter(float* x, float* y);

    // Initialicing functions for the filters

    SimpleFilter* filter1;
    SimpleFilter* filter2;
};


#endif // DOUBLEFILTER_H
