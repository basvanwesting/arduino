/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
  Example uses a static library to show off generate_arduino_library().
 
  This example code is in the public domain.
 */
#include "Arduino.h"
#include "blink_lib.h"

void setup() {
  blink_setup(); // Setup for blinking
  Serial.begin(9600);
}

void loop() {
  Serial.println("begin of loop");
  blink(1000); // Blink for a second
  Serial.println("end of loop");
}
