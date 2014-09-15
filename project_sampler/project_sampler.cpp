#include "Arduino.h"
#include "../libraries/Sampler/Sampler.h"

Sampler sampler(A0, 10);
int val;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  val = sampler.sample();

  Serial.print("timestamp: ");
  Serial.print(millis());
  Serial.print(" sample value: ");
  Serial.println(val);
}
