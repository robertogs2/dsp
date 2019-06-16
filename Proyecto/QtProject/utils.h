/**
 * \file   utils.h
 */

#ifndef UTILS_H
#define UTILS_H

#include "constants.h"
class utils{
public:
    utils();
    static void getFrequency(const char c, float& frequencyZero, float& frequencyOne);
    static char getChar(int i, int j);
    static std::string filterNumber(std::string input);
    static std::string called(std::string input);
};

#endif // UTILS_H
