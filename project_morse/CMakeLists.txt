cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE /Users/basvanwesting/workspace/arduino-cmake/cmake/ArduinoToolchain.cmake) # Arduino Toolchain
project(ArduinoExample C CXX)

#set(${FIRMWARE_NAME}_PORT /dev/tty.usbmodem1411)

#====================================================================#
# Advanced static library exmaple
#====================================================================#
generate_arduino_library(morse_lib
  SRCS ../libraries/Morse/Morse.cpp
  HDRS ../libraries/Morse/Morse.h
  BOARD uno)

#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(morse
  SRCS project_morse.cpp
  LIBS morse_lib
  PORT /dev/tty.usbmodem1411
  SERIAL picocom @SERIAL_PORT@ -b 9600 -l
  BOARD uno)

