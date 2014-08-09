int pinValue = 0;

void setup() {
  pinMode(2, INPUT);
  pinMode(9, OUTPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  pinValue = digitalRead(2);
  if (pinValue == HIGH) {
    digitalWrite(9,HIGH);
    digitalWrite(13,HIGH);
  } else {
    digitalWrite(9,LOW);
    digitalWrite(13,LOW);
  }
  delay(100);
}

