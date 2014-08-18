#include "Arduino.h"
#include "blink_lib.h"

void blink_setup(int pin) {
  pinMode(pin, OUTPUT);
}


void blink(long duration, int pin) {
  digitalWrite(pin, HIGH);   // set the LED on
  delay(duration);           // wait for a second
  digitalWrite(pin, LOW);    // set the LED off
  delay(duration);           // wait for a second
}
