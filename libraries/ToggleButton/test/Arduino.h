#ifndef Arduino_h
#define Arduino_h

#include <stdint.h>

#define HIGH 0x1
#define LOW  0x0

#define INPUT 0x0
#define OUTPUT 0x1

inline void pinMode(uint8_t pin, uint8_t input) {};
inline int digitalRead(uint8_t pin) { return 0; };
inline void delay(unsigned long) {};

#endif
