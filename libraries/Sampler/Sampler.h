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
    Sampler(uint8_t pin, uint8_t frequency, uint8_t max_samples);
    ~Sampler();
    void cycle();
    uint8_t* get_samples();
    void add_sample(uint8_t);
  private:
    uint8_t _pin;
    uint8_t _frequency;
    uint8_t _max_samples;
    uint8_t* _samples;
};

#endif

