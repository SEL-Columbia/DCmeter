int apin0 = 0;
int apin1 = 1;
int apin2 = 2;
int apin3 = 3;
int apin4 = 4;
int apin5 = 5;
float v0;
float v1;
float v2;
float v3;
float v4;
float v5;
float Vratio = ((510.0+100.0)/100.0);  //((28.0+422.0)/28.0);  //reverse voltage-divider
float current0;
float current1;
float current2;

unsigned long now;
unsigned long then = 0;

void setup(){
  Serial.begin(9600);
  Serial.println("starting...");
}

void loop(){
  now = millis();
  if ((now - then) >= 15000 || now < 100){  //every minute
    //read analog signals
    v0 = analogRead(apin0)*(5.0/1024);
    v1 = analogRead(apin1);
    Serial.print("raw data on pin a1: ");
    Serial.println(v1);
    v1 = v1 *(5.0/1024);
    v2 = analogRead(apin2)*(5.0/1024);
    v3 = analogRead(apin3);
    //Serial.print("raw data on pin a3: ");
    //Serial.println(v3);
    v3 = v3 * (5.0/1024);
    v4 = analogRead(apin4);
    Serial.print("raw data on pin a4: ");
    Serial.println(v4);
    v4 = v4 *(5.0/1024); 
    v5 = analogRead(apin5);
    Serial.print("raw data on pin a5: ");
    Serial.println(v5);
    v5 = v5 * (5.0/1024);
    float gnd = 0.0;                        //use a5 for grnd for now
    //calculate current from output voltage
    //first is panel-to-battery up to ~30A ::
    current0 = (v0 - 0.5) / 0.133;        //0.133V/A
    //second (and later third) is battery-to-inverter (and metering)
    //up to +/- 5A ::
    current1 = (v1 - 2.525)/ 0.185;       //0.185V/A
    current2 = (v2 - 2.525)/ 0.185;       //0.185V/A
    //send out current info
    //Serial.print("panel_current_A: ");
    //Serial.println(current0);
    //Serial.print("panel_voltage_V: ");
    //Serial.println(Vratio*(v3-gnd));            //across R     
    Serial.print("battery_mains_current_A: ");
    Serial.println(current1);
    Serial.print("battery_mains_voltage_V: ");
    Serial.println(Vratio*(v4-gnd));              //across R
    //Serial.print("battery_metering_current_A: ");
    //Serial.println(current2);
    //Serial.print("battery_metering_voltage_V: ");
    //Serial.println(Vratio*v5);
    //Serial.print("time_interval_sec: ");
    //Serial.println((now-then)/1000);
    Serial.println("----------------------------");
    then = now;
  }
  
}
