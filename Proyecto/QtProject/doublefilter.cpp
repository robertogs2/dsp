#include "doublefilter.h"

DoubleFilter::DoubleFilter()
{

}

void DoubleFilter::filter(float *x, float *y){
    filter1->filter(x, y);
    filter2->filter(y, y);
}
