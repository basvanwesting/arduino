/*
  Sampler.h - Library for a toggle button.
  Created by Bas van Westing, Apr 6, 2014.
  Released into the public domain.
*/

#include "Arduino.h"
#include "Sampler.h"

Sampler::Sampler(int pin, int frequency)
{
  _pin = pin;
  _frequency = frequency;
  _last_sample_timestamp = millis();
};

Sampler::~Sampler() {
};

int Sampler::pin() {
  return _pin;
}

int Sampler::frequency() {
  return _frequency;
}

int Sampler::sample() {
  int required_delay = this->delay_to_next_sample();
  if(required_delay > 0) {
    delay(required_delay);
  } else {
    Serial.print("UNDERSAMPLING ");
    Serial.println(required_delay);
  }

  _last_sample_timestamp = millis();
  return analogRead(_pin);
};

int Sampler::interval_in_ms() {
  return 1000 / _frequency;
}

int Sampler::delay_to_next_sample() {
  return _last_sample_timestamp + this->interval_in_ms() - millis();
};
