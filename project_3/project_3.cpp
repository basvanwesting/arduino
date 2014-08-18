#include "Arduino.h"

const int sensorPin = A0;
const float baselineTemp = 23.0;
const int step = 1;

void setup() {
  Serial.begin(9600);
  for(int p=2;p<5;p++) {
    pinMode(p,OUTPUT);
    digitalWrite(p,LOW);
  }
}

void loop() {
  int sensorVal = analogRead(sensorPin);
  Serial.print("Sensor Value: ");
  Serial.print(sensorVal);

  float voltage = (sensorVal/1024.0) * 5.0;
  Serial.print(", Volts: ");
  Serial.print(voltage);

  float temperature = (voltage - 0.5) * 100;
  Serial.print(", degrees C: ");
  Serial.print(temperature);
  Serial.print("\n");

  if(temperature < baselineTemp) {
    digitalWrite(2,LOW);
    digitalWrite(3,LOW);
    digitalWrite(4,LOW);
  } else if(temperature >= baselineTemp + step && temperature < baselineTemp + 2*step) {
    digitalWrite(2,HIGH);
    digitalWrite(3,LOW);
    digitalWrite(4,LOW);
  } else if(temperature >= baselineTemp + 2*step && temperature < baselineTemp + 3*step) {
    digitalWrite(2,HIGH);
    digitalWrite(3,HIGH);
    digitalWrite(4,LOW);
  } else if(temperature >= baselineTemp + 3*step){
    digitalWrite(2,HIGH);
    digitalWrite(3,HIGH);
    digitalWrite(4,HIGH);
  }
  delay(1000);
}
