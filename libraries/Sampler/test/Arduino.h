#ifndef Arduino_h
#define Arduino_h

#include <stdint.h>
#include <chrono>
#include <unistd.h>
#include <iostream>
#include <sstream>

#define HIGH 0x1
#define LOW  0x0

#define INPUT 0x0
#define OUTPUT 0x1

inline void pinMode(uint8_t pin, uint8_t input) {};
inline int digitalRead(uint8_t pin) { return 0; };
inline int analogRead(uint8_t pin) { return 0; };
inline void delay(unsigned long ms) { usleep(ms*1000); };
inline unsigned long millis() {
  return std::chrono::duration_cast<std::chrono::milliseconds>(
      std::chrono::system_clock::now().time_since_epoch()
  ).count();
}

class SerialClass {
  public:
    void print(std::string s) {
      std::cout << s;
    }
    void println(std::string s) {
      std::cout << s << std::endl;
    }
    void print(int i) {
      std::cout << i;
    }
    void println(int i) {
      std::cout << i << std::endl;
    }
};

#define Serial SerialClass()

#endif
