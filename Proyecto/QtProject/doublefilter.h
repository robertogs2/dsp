#ifndef DOUBLEFILTER_H
#define DOUBLEFILTER_H

#include "simplefilter.h"
class DoubleFilter
{
public:
	// Constructor for Doublefilter
    DoubleFilter(int sizeX1, int sizeY1, int sizeX2, int sizeY2, int bufferSize);
    
    //Function to filter x into y
    void filter(float* x, float* y);

    // Initialicing functions for the filters
    void setCoefficient(const float* coeffX0, const float* coeffX1, const float* coeffY0, const float* coeffY1, const float gain1, const float gain2);
    
    // First filter
    SimpleFilter* filter1_;

    // Second filter
    SimpleFilter* filter2_;

    // Size of the vectors to filter
    int _bufferSize;

    // Pivot signal to filter in between both simple filters
    float* _middleSignal;
};


#endif // DOUBLEFILTER_H
