/*
  ToggleButton.h - Library for a toggle button.
  Created by Bas van Westing, Apr 6, 2014.
  Released into the public domain.
*/

#ifndef ToggleButton_h
#define ToggleButton_h

#include "Arduino.h"

class ToggleButton
{
  public:
    ToggleButton(uint8_t pin);
    void cycle();
    void toggle();
    bool changedUp();
    bool changedDown();
    bool isOn();
  private:
    uint8_t _pin;
    uint8_t _currentState;
    uint8_t _prevState;
    bool _toggleState;
};

#endif

