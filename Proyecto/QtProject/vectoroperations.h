#ifndef VECTOROPERATIONS_H
#define VECTOROPERATIONS_H

#include <algorithm>
#include <iostream>
class VectorOperations{
public:
    static void copyVector(const float* vectorA, float* vectorB, int length);
    static void squareVector(float* vectorA, float* vectorB, int length);
    static void averageVector(float* vectorA, float* vectorB, int length, int m);
    static int digitalizeVector(float* vectorA, float* vectorB, int length, float limit, float value);
    static void shiftVector(float* vectorA, float* vectorB, int length, int amount);
    static void shiftAndConcatenateVector(float* vectorA, float* vectorB, float* vectorC, int lengthLarge, int lengthSmall);
    static void delayVector(float* vectorA, float* vectorB, int delay, int length);
    static int countOnes(float* vectorA, int length);
    static void printVector(float* vectorA, int length);

    static int averageDigitalizeCounterVector(float* vectorA, int length, int m, float limit);
};

#endif // VECTOROPERATIONS_H
