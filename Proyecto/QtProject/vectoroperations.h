#ifndef VECTOROPERATIONS_H
#define VECTOROPERATIONS_H

#include <algorithm>
#include <iostream>
class VectorOperations{
public:
    // Copies a vector into another
    static void copyVector(const float* vectorA, float* vectorB, int length);

    // Calculates the square of a vector
    static void squareVector(float* vectorA, float* vectorB, int length);

    // Calculates the moving average of a vector with size m
    static void averageVector(float* vectorA, float* vectorB, int length, int m);

    // Digitalized a vector given a value and a limit
    static int digitalizeVector(float* vectorA, float* vectorB, int length, float limit, float value);

    // Shifts a vector an amount of units to the right
    static void shiftVector(float* vectorA, float* vectorB, int length, int amount);

    // Shifts a vector and concatenates another in the empty space
    static void shiftAndConcatenateVector(float* vectorA, float* vectorB, float* vectorC, int lengthLarge, int lengthSmall);

    // Delays a vector delay units
    static void delayVector(float* vectorA, float* vectorB, int delay, int length, bool fill);

    // Counts the amount of ones in a vector
    static int countOnes(float* vectorA, int length);

    // Calculates the average of a vector
    static float average(float* vectorA, int length);

    // Prints a vector
    static void printVector(float* vectorA, int length);

    // Caclulates the average, digitalized and count ones in a ingle function
    static int averageDigitalizeCounterVector(float* vectorA, int length, int m, float limit);
};

#endif // VECTOROPERATIONS_H
