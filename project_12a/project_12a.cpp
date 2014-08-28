#include "Arduino.h"

const int piezo = A0;
int piezoVal;

void setup(){
  Serial.begin(9600);
}

void loop(){
  piezoVal = analogRead(piezo);
  if(piezoVal > 0){
    Serial.print("The piezo output is ");
    Serial.println(piezoVal);
  }
}
