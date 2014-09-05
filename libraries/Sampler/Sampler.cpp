/*
  Sampler.h - Library for a toggle button.
  Created by Bas van Westing, Apr 6, 2014.
  Released into the public domain.
*/

#include "Arduino.h"
#include "Sampler.h"

Sampler::Sampler(uint8_t pin, uint8_t frequency, uint8_t max_samples)
{
  _pin = pin;
  _frequency = frequency;
  _max_samples = max_samples;
  _samples = new uint8_t[max_samples];

  pinMode(pin, INPUT);
};

Sampler::~Sampler() {
  delete _samples;
}

void Sampler::cycle() {
};

uint8_t* Sampler::get_samples() {
  return _samples;
};

void Sampler::add_sample(uint8_t sample) {

};
