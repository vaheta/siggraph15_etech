#include <Servo.h> 
Servo myservo;
int angle;
int incomingByte = 0; 
void setup() {
  // put your setup code here, to run once:
  myservo.attach(3);
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();
    
    // say what you got:
    Serial.print("I received: ");
    Serial.println(incomingByte);
    if (incomingByte == 122)
    {
        myservo.write(0);
        delay(2000);
    }
    if (incomingByte == 103)
    {
        angle = myservo.read();
        Serial.print("Angle before= ");
        Serial.println(angle);
        angle = angle + 45;
        myservo.write(angle);
        Serial.print("Angle after= ");
        Serial.println(angle);
        delay(2000);
    }
    if (angle>=90)
    {
      myservo.write(0);
    }
  }
}
