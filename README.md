arduino
=======

Arduino play stuff

Dependencies:
* [https://code.google.com/p/googlemock/]
* [https://github.com/queezythegreat/arduino-cmake]

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

