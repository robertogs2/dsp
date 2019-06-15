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
    static constexpr inline float sideFrequencies[4] = {697, 770, 852, 941};
    static constexpr inline float upperFrequencies[4] = {1209, 1336, 1477, 1633};

    // Digits
    inline static constexpr char digits[16] = {'1', '2', '3', 'A', '4', '5', '6', 'B', '7', '8', '9', 'C', '*', '0', '#', 'D'};

    // Sample limit for each tone
    static const int limit40 = 1763;

    // Button words
    inline static const std::string desc = "Descolgar";
    inline static const std::string col = "Colgar";



    // Filter constants

    // General
    static const int movingAverageSamples = 1000;
    static const int filterAmount = 8;
    static const int filterBuffers = 3;

    // Side frequencies
    // 697 Hz
    float gain_697 = 0.0014948343;

    static const int sizeX1_697 = 3;
    static constexpr inline float coeffX1_697[3] ={1, 0, -1};
    static const int sizeY1_697 = 2;
    static constexpr inline float coeffY1_697[2] = {-1.98831761064, 0.998417227816};

    static const int sizeX2_697 = 3;
    static constexpr inline float coeffX2_697[3] ={1, 0, -1};
    static const int sizeY2_697 = 2;
    static constexpr inline float coeffY2_697[2] = {-1.98886276558, 0.998457206963};


};

#endif // CONSTANTS_H
