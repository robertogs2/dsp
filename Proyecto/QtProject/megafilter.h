#ifndef MEGAFILTER_H
#define MEGAFILTER_H

#include "doublefilter.h"
#include "vectoroperations.h"
#include "constants.h"

class MegaFilter
{
public:
    MegaFilter();
    void init(int buffers, int bufferSize);
    void setEmpiricalVariables(int movingAverageSamples, float digitalThreshold, int mininumHigh);
    void filter(float* x);
    bool analyze();

    int _buffers;
    int _bufferSize;

    int _movingAverageSamples;
    float _digitalThreshold;
    int _mininumHigh;

    float* _filteredSignal;
    float* _tempSignal1;
    float* _tempSignal2;
    DoubleFilter* _filterUnit;
};

#endif // MEGAFILTER_H
