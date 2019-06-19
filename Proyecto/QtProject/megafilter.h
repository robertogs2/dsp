#ifndef MEGAFILTER_H
#define MEGAFILTER_H

#include "doublefilter.h"
#include "vectoroperations.h"
#include "constants.h"

class MegaFilter
{
public:
    // Mega filter constructor
    MegaFilter();

    // Initializes the mega filter
    void init(int buffers, int bufferSize);

    // Sets the empirical values for the filter
    void setEmpiricalVariables(int movingAverageSamples, float digitalThreshold, int mininumHigh);
    
    // Filters the signal x into the filtered signal variable of the filter
    void filter(float* x);

    //  Analyzes the result of the filter into a number representing a hit value between 0 and 2047 for the signal
    int analyze();

    // Amount of buffers to contain
    int _buffers;

    // Size of each buffer
    int _bufferSize;


    int _movingAverageSamples; // Samples for average
    float _digitalThreshold; // threshold for energy
    int _mininumHigh; // minimun amount of samples to be one to consider

    // Filtered signal using the double filter
    float* _filteredSignal;

    // Temporal signal 1
    float* _tempSignal1;

    // Temporal signal 2
    float* _tempSignal2;

    // Filter unit as a double filter
    DoubleFilter* _filterUnit;

    int _states[3];

};

#endif // MEGAFILTER_H
