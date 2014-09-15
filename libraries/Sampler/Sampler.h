/*
  Sampler.h - Library for a toggle button.
  Created by Bas van Westing, Apr 6, 2014.
  Released into the public domain.
*/

#ifndef Sampler_h
#define Sampler_h

#include "Arduino.h"

class Sampler
{
  public:
    Sampler(int, int);
    ~Sampler();
    int pin();
    int frequency();
    int interval_in_ms();
    int delay_to_next_sample();
    int sample();
  private:
    int _pin;
    int _frequency;
    unsigned long _last_sample_timestamp;
};

#endif

