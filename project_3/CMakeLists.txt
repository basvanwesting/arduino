cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE /Users/basvanwesting/workspace/arduino-cmake/cmake/ArduinoToolchain.cmake) # Arduino Toolchain
project(ArduinoExample C CXX)

#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(project_3
    SRCS project_3.cpp
    PORT /dev/tty.usbmodem1411
    SERIAL picocom @SERIAL_PORT@ -b 9600 -l
    BOARD uno)


