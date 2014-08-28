#ifndef Arduino_h
#define Arduino_h

#include <stdint.h>

#define HIGH 0x1
#define LOW  0x0

#define INPUT 0x0
#define OUTPUT 0x1

void pinMode(uint8_t, uint8_t);
int digitalRead(uint8_t);
void delay(unsigned long);


#endif
