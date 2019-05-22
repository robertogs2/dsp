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

    static constexpr float upperFrequencies[4] = {1209, 1336, 1477, 1633};
    static constexpr float sideFrequencies[4] = {697, 770, 852, 941};

    
};

#endif // CONSTANTS_H
