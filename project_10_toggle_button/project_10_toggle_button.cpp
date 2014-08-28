// based on project 10 of the arduino starter kit

#include "Arduino.h"
#include "ToggleButton/ToggleButton.h"

const int controlPin1 = 2;
const int controlPin2 = 3;
const int enablePin = 9;
const int potPin = A0;

ToggleButton onOffButton(5);
ToggleButton directionButton(4);

int motorSpeed = 0;

void setup() {
  pinMode(controlPin1, OUTPUT);
  pinMode(controlPin2, OUTPUT);
  pinMode(enablePin, OUTPUT);
  digitalWrite(enablePin,LOW);
}

void loop() {
  onOffButton.cycle();
  directionButton.cycle();
  motorSpeed = analogRead(potPin)/4;

  if(directionButton.isOn()) {
    digitalWrite(controlPin1, HIGH);
    digitalWrite(controlPin2, LOW);
  } else {
    digitalWrite(controlPin1, LOW);
    digitalWrite(controlPin2, HIGH);
  }

  if(onOffButton.isOn()) {
    analogWrite(enablePin, motorSpeed);
  } else {
    analogWrite(enablePin, 0);
  }
}

