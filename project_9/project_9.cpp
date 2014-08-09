int pinValue = 0;

class Test {
  int pin;
  public:
    Test(int p): pin(p) {};
    void setPin(int p) { pin = p; }
    int getPin() { return pin; }
};

Test a {12};

void setup() {
  pinMode(2, INPUT);
  pinMode(9, OUTPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  a.setPin(10);

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

