
void setup() {
  for(int p=2;p<5;p++) {
    pinMode(p,OUTPUT);
    digitalWrite(p,LOW);
  }
  pinMode(8,INPUT);
}

const int speed = 100;
int switchState = 0;

void loop() {
  switchState = digitalRead(8);
  if(switchState == HIGH) {
    digitalWrite(2,HIGH);
    digitalWrite(3,LOW);
    digitalWrite(4,LOW);
    delay(speed);
    digitalWrite(2,LOW);
    digitalWrite(3,HIGH);
    digitalWrite(4,LOW);
    delay(speed);
    digitalWrite(2,LOW);
    digitalWrite(3,LOW);
    digitalWrite(4,HIGH);
    delay(speed);
  } else {
    digitalWrite(2,LOW);
    digitalWrite(3,LOW);
    digitalWrite(4,LOW);
    delay(100);
  };  
}

