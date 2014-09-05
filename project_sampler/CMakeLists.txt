cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE $ENV{ARDUINO_CMAKE_HOME}/cmake/ArduinoToolchain.cmake) # Arduino Toolchain
project(ArduinoExample C CXX)

#set(${FIRMWARE_NAME}_PORT /dev/tty.usbmodem1411)

#====================================================================#
# Advanced static library exmaple
#====================================================================#
generate_arduino_library(sampler_lib
  SRCS ../libraries/Sampler/Sampler.cpp
  HDRS ../libraries/Sampler/Sampler.h
  BOARD uno)

#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(sampler
  SRCS project_sampler.cpp
  LIBS sampler_lib
  PORT /dev/tty.usbmodem1411
  SERIAL picocom @SERIAL_PORT@ -b 9600 -l
  BOARD uno)

