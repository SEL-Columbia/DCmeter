int apin0 = 0;
int apin1 = 1;
int apin2 = 2;
//int apin3 = 3;
//int apin4 = 4;
//int apin5 = 5;
float v0;
float v1;
float v2;
//float v3;
//float v4;
//float v5;
float Ri = 0.0012;    //internal resistance of pololu ~1.2mohm
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
    v0 = analogRead(apin0);
    v1 = analogRead(apin1);
    v2 = analogRead(apin2);
    //calculate current from output voltage
    //first is panel-to-battery up to ~30A
    current1 = (v0 - 2.525)/ 0.185; //0.185V/A
    //second (and later third) is battery-to-inverter (and metering)
    current2 = (v1 - 0.5) / 0.133;  //0.133V/A
    current3 = (v2 - 0.5) / 0.133;
    //send out current info
    Serial.print("panel_current_A: ");
    Serial.println(current1);
    Serial.print("panel_voltage_V: ");
    Serial.println(current1*Ri);      
    Serial.print("battery_mains_current_A: ");
    Serial.println(current2);
    Serial.print("battery_mains_voltage_V: ");
    Serial.println(current2*Ri);
    Serial.print("battery_metering_current_A: ");
    Serial.println(current3);
    Serial.print("battery_metering_voltage_V: ");
    Serial.println(current3*Ri);
    Serial.print("time_interval_sec: ");
    Serial.println((now-then)/1000);
    then = now;
  }
  
}
