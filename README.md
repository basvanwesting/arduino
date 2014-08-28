arduino
=======

Arduino play stuff.
Using cmake to build and upload the firmware. e.g.:
```
$ cd project_morse
$ cbuild
$ mybuild/make upload
$ mybuild/make morse-serial # "<project name>-serial" for stream of serial port
```

Using cmake to run the library test suites. e.g.:
```
$ cd libraries/ToggleButton
$ cbuildtest
```

Dependencies:
* https://code.google.com/p/googlemock/
* https://github.com/queezythegreat/arduino-cmake/

Environment
```
export ARDUINO_PROJECTS_HOME=<this-repo-root>
export CC="/usr/local/bin/gcc-4.7"
export CXX="/usr/local/bin/g++-4.7"
export GMOCK_HOME=...
export GTEST_HOME=$GMOCK_HOME/gtest
export ARDUINO_CMAKE_HOME=...
```

Build gtest and gmock with the same CC/CXX.

Bash utility functions:
```
function cbuild() {
  rm -rf mybuild
  mkdir mybuild
  cd mybuild
  CC="/usr/local/bin/gcc-4.7" CXX="/usr/local/bin/g++-4.7" cmake ..
  make
  cd ..
}

function cbuildtest() {
  cbuild
  mybuild/test
}
```


