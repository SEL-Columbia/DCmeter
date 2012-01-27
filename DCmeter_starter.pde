
int apin1 = 1;
int apin2 = 2;
int apin3 = 3;
float v1;
float v2;
float v3;
float current1;
float current2;
float current3;

unsigned long now;
unsigned long then = 0;

void setup(){
  Serial.begin(9600);
}

void loop(){
  now = millis();
  if ((now - then) >= 60000 || now < 100){  //every minute
    //read analog signals
    v1 = analogRead(apin1);
    v2 = analogRead(apin2);
    v3 = analogRead(apin3);
    //calculate current from output voltage
    //first is panel-to-battery up to ~30A
    current1 = (v1 - 2.525)/ 0.185; //0.185V/A
    //second (and later third) is battery-to-inverter (and metering)
    current2 = (v2 - 0.5) / 0.133;  //0.133V/A
    current3 = (v3 - 0.5) / 0.133;
    //send out current info
    Serial.print(current1);
    Serial.print(current2);
    Serial.print(current3);
    then = now;
  }
  
}
