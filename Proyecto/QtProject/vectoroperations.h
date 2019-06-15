#ifndef VECTOROPERATIONS_H
#define VECTOROPERATIONS_H

#include <algorithm>
#include <iostream>
class VectorOperations{
public:
    static void copyVector(float* vectorA, float* vectorB, int length);
    static void squareVector(float* vectorA, float* vectorB, int length);
    static void averageVector(float* vectorA, float* vectorB, int length, int m);
    static void printVector(float* vectorA, int length);
};

#endif // VECTOROPERATIONS_H
