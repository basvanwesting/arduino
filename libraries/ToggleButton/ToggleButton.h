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
    ToggleButton(int pin);
    void cycle();
    void toggle();
    bool changedUp();
    bool changedDown();
    bool isOn();
  private:
    int _pin;
    int _currentState;
    int _prevState;
    bool _toggleState;
};

#endif

