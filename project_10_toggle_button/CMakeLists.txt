cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE $ENV{ARDUINO_CMAKE_HOME}/cmake/ArduinoToolchain.cmake) # Arduino Toolchain
project(ArduinoExample C CXX)
include_directories($ENV{ARDUINO_PROJECTS_HOME}/libraries)

#====================================================================#
# Advanced static library exmaple
#====================================================================#
generate_arduino_library(toggle_button_lib
  SRCS $ENV{ARDUINO_PROJECTS_HOME}/libraries/ToggleButton/ToggleButton.cpp
  HDRS $ENV{ARDUINO_PROJECTS_HOME}/libraries/ToggleButton/ToggleButton.h
  BOARD uno)

#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(project_10_toggle_button
  SRCS project_10_toggle_button.cpp
  LIBS toggle_button_lib
  PORT /dev/tty.usbmodem1411
  SERIAL picocom @SERIAL_PORT@ -b 9600 -l
  BOARD uno)

