#include "utils.h"

utils::utils(){

}

void utils::getFrequency(const char c, float& frequencyLeft, float& frequencyUp){
    switch(c){
        case '1': case '2': case '3': case 'A': {
            frequencyLeft = constants::sideFrequencies[0];
            break;
        }
        case '4': case '5': case '6': case 'B': {
            frequencyLeft = constants::sideFrequencies[1];
            break;
        }
        case '7': case '8': case '9': case 'C': {
            frequencyLeft = constants::sideFrequencies[2];
            break;
        }
        case '*': case '0': case '#': case 'D': {
            frequencyLeft = constants::sideFrequencies[3];
            break;
        }
        default:{
                break;
        }
    }

    switch(c){
        case '1': case '4': case '7': case '*': {
            frequencyUp = constants::upperFrequencies[0];
            break;
        }
        case '2': case '5': case '8': case '0': {
            frequencyUp = constants::upperFrequencies[1];
            break;
        }
        case '3': case '6': case '9': case '#': {
            frequencyUp = constants::upperFrequencies[2];
            break;
        }
        case 'A': case 'B': case 'C': case 'D': {
            frequencyUp = constants::upperFrequencies[3];
            break;
        }
        default:{
                break;
        }
    }
}

char utils::getChar(int i, int j){
    return constants::digits[j+4*i];
}
