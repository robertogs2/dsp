#ifndef CONSTANTS_H
#define CONSTANTS_H

#include "structs.h"

class constants{
public:
    static const int minFrequency = 20;
    static const int maxFrequency = 22000;
    static const int volumeMaxGain = 50;
    static constexpr float slope = float(maxFrequency-minFrequency)/float(volumeMaxGain);
    static const int volume = 20;

    static constexpr float sideFrequencies[4] = {1,2,3,4};
    static constexpr float upperFrequencies[4] = {5,6,7,8};

    
};

#endif // CONSTANTS_H
