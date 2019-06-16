#include "vectoroperations.h"

// Not tested
void VectorOperations::copyVector(const float *vectorA, float *vectorB, int length){
    for(int i = 0; i < length; ++i){
        vectorB[i] = vectorA[i];
    }
}

void VectorOperations::squareVector(float *vectorA, float *vectorB, int length){
    for(int i = 0; i < length; ++i){
        vectorB[i] = vectorA[i]*vectorA[i];
    }
}

void VectorOperations::averageVector(float *vectorA, float *vectorB, int length, int m){
    // Leave number odd evertime
    if(m & 1 == 0){
        m = --m;
    }

    int n = (m-1) >> 1; // Samples to each side to get

    for(int i = 0; i < length; ++i){
        int counter = 0;
        float sum = 0;
        // Sum to the left
        for(int k = i-1; k >= std::max(i-n, 0); --k){
            //std::cout << k << std::endl;
            sum += vectorA[k];
            ++counter;
        }

        sum += vectorA[i];
        ++counter;
        // Sum to the right
        for(int k = i+1; k <= std::min(i+n, length-1); ++k){
            sum += vectorA[k];
            ++counter;
        }
        vectorB[i] =  sum/counter;
    }
}

void VectorOperations::printVector(float *vectorA, int length){
    //std :: cout << length << std::endl;
    for(int i = 0; i < length; ++i){
        std::cout << vectorA[i] << " ";
    }
    std::cout << std::endl;
}

// Not tested
void VectorOperations::digitalizeVector(float *vectorA, float *vectorB, int length, float limit, float value){
    for(int i = 0; i < length; ++i){
        if(vectorA[i] >= limit) vectorB[i] = value;
        else vectorB[i] = 0;
    }
}

// Moves vector to left and fills empty space with vectorC, vectorC.length = lengthSmall is needed
void VectorOperations::shiftAndConcatenateVector(float *vectorA, float *vectorB, float *vectorC, int lengthLarge, int lengthSmall){
    int i = 0;
    for(; i+lengthSmall < lengthLarge; ++i){
        vectorB[i] = vectorA[i+lengthSmall];
    }
    for(int j = 0;i < lengthLarge;++i){
        vectorB[i] = vectorC[j];
        ++j;
    }
}

// Not tested
void VectorOperations::delayVector(float *vectorA, float *vectorB, int delay, int length){
    int i = length-1;
    for(; i-delay >= 0; --i){
        vectorB[i] = vectorA[i-delay];
    }
    // Fills the rest with zeros
    for(;i>=0;--i){
        vectorB[i] = 0;
    }
}

int VectorOperations::countOnes(float* vectorA, int length){
    int counter = 0;
    for(int i = 0; i < length; ++i){
        counter += vectorA[i]==1;
    }
    return counter;
}

