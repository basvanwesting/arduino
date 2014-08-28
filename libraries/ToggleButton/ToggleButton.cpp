/*
  ToggleButton.h - Library for a toggle button.
  Created by Bas van Westing, Apr 6, 2014.
  Released into the public domain.
*/

#include "Arduino.h"
#include "ToggleButton.h"

ToggleButton::ToggleButton(uint8_t pin)
{
  pinMode(pin, INPUT);
  _pin = pin;
  _prevState = LOW;
  _currentState = LOW;
  _toggleState = false;
};

void ToggleButton::cycle() {
  _prevState = _currentState;
  _currentState = digitalRead(_pin);
  delay(1);
  if(changedUp()) {
    toggle();
  }
};

bool ToggleButton::changedUp() {
  if((_currentState != _prevState) && (_currentState == HIGH)) {
    return true;
  } else {
    return false;
  }
};

bool ToggleButton::changedDown() {
  if((_currentState != _prevState) && (_currentState == LOW)) {
    return true;
  } else {
    return false;
  }
};

void ToggleButton::toggle() {
  _toggleState = !_toggleState;
};

bool ToggleButton::isOn() {
  return _toggleState;
};

