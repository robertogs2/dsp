/**
 * \file   constants.h
 */

#ifndef CONSTANTS_H
#define CONSTANTS_H

#include <string>

class constants{
public:
    // Test settings
    static const int minFrequency = 20;
    static const int maxFrequency = 22000;
    static const int volumeMaxGain = 50;
    static constexpr float slope = float(maxFrequency-minFrequency)/float(volumeMaxGain);
    static const int volume = 20;

    // Frequencies
    inline static constexpr float upperFrequencies[4] = {1209, 1336, 1477, 1633};
    inline static constexpr float sideFrequencies[4] = {697, 770, 852, 941};

    // Digits
    inline static constexpr char digits[16] = {'1', '2', '3', 'A', '4', '5', '6', 'B', '7', '8', '9', 'C', '*', '0', '#', 'D'};

    // Sample limit for each tone
    static const int limit40 = 1763;

    // Button words
    inline static const std::string desc = "Descolgar";
    inline static const std::string col = "Colgar";

    static const int movingAverageSamples = 1000;
};

#endif // CONSTANTS_H
