#ifndef CONSTANTS_H
#define CONSTANTS_H

class constants{
public:
    static const int minFrequency = 20;
    static const int maxFrequency = 22000;
    static const int volumeMaxGain = 50;
    static constexpr float slope = float(maxFrequency-minFrequency)/float(volumeMaxGain);
    static const int volume = 5;
};

#endif // CONSTANTS_H
