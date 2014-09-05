#include "Arduino.h"
#include "../libraries/Sampler/Sampler.h"

Sampler sampler(A0, 8, 128);

void setup()
{
}

void loop()
{
  sampler.cycle();
}
