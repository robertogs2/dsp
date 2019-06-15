#include "doublefilter.h"

DoubleFilter::DoubleFilter(){

}

void DoubleFilter::filter(float *x, float *y){
    filter1->filter(x, y);
    filter2->filter(y, y);
}

void DoubleFilter::setCoefficient(float *coeffX0, float *coeffX1, float *coeffY0, float *coeffY1){
    filter1->setCoefficients(coeffX0, coeffY0);
    filter2->setCoefficients(coeffX1, coeffY1);
}
