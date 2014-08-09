const int redLEDPin = 11;
const int greenLEDPin = 9;
const int blueLEDPin = 10;

int redValue = 0;
int greenValue = 0;
int blueValue = 0;

void setup() {
  pinMode(redLEDPin,OUTPUT);
  pinMode(greenLEDPin,OUTPUT);
  pinMode(blueLEDPin,OUTPUT);
}

int redFactor(int value) {
  return value / 2;
};
int greenFactor(int value) {
  return value;
};
int blueFactor(int value) {
  return value / 2;
};

void loop() {
  for(int i=0;i<256;++i) {
    analogWrite(redLEDPin,redFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(redLEDPin,redFactor(i));
    delay(8);
  }
  for(int i=0;i<256;++i) {
    analogWrite(greenLEDPin,greenFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(greenLEDPin,greenFactor(i));
    delay(8);
  }
  for(int i=0;i<256;++i) {
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }

  for(int i=0;i<256;++i) {
    analogWrite(redLEDPin,redFactor(i));
    analogWrite(greenLEDPin,greenFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(redLEDPin,redFactor(i));
    analogWrite(greenLEDPin,greenFactor(i));
    delay(8);
  }
  for(int i=0;i<256;++i) {
    analogWrite(greenLEDPin,greenFactor(i));
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(greenLEDPin,greenFactor(i));
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }
  for(int i=0;i<256;++i) {
    analogWrite(redLEDPin,redFactor(i));
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }
  for(int i=256;i>0;--i) {
    analogWrite(redLEDPin,redFactor(i));
    analogWrite(blueLEDPin,blueFactor(i));
    delay(8);
  }
}





