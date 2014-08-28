cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE $ENV{ARDUINO_CMAKE_HOME}/cmake/ArduinoToolchain.cmake) # Arduino Toolchain
project(ArduinoExample C CXX)

#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(project_12a
  SRCS project_12a.cpp
  PORT /dev/tty.usbmodem1411
  SERIAL picocom @SERIAL_PORT@ -b 9600 -l
  BOARD uno)

