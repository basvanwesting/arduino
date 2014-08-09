const int ledPin = 3;
const int sensorPin = A0;

int value = 0;
int sensorValue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin,OUTPUT);
}

void loop() {
  sensorValue = analogRead(sensorPin);

  Serial.print("Raw Sensor Values: ");
  Serial.println(sensorValue);

  value = sensorValue/4;

  Serial.print("Mapped Sensor Values: ");
  Serial.println(value);

  analogWrite(ledPin, value);
}





