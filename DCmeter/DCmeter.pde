//int apin[6];    
float v[6];    //v0-2 for current measurements, v4:V_batt, v5:V_panels
float Vratio = ((510.0+100.0)/100.0);  //((28.0+422.0)/28.0);  //reverse voltage-divider
float V_battery;
float V_panels;
float current[3];
float energy[3] = {0,0,0};
int time_interval = 1000;  //every sec
int sendtime_interval = 15000;  //every 15 sec

unsigned long now;
unsigned long then = 0;
unsigned long sendtime = 0;

void setup(){
  Serial.begin(9600);
  Serial.println("starting...");
}

void loop(){
  now = millis();
  if ((now - then) >= time_interval || now < 100){    //loop to sample data
    //read analog signals
    for (int i=0; i<6; i++){
      v[i] = analogRead(i)*(5.0/1024.0);
      //Serial.println(i);
    }
    //Serial.print("raw data on pin a1: ");
    //Serial.println(v[1]);
    //Serial.println(v[4]);

    //calculate current from output voltage
    //first is panel-to-battery up to ~30A ::
    current[0] = (v[0] - 0.5) / 0.133;        //0.133V/A
    //second (and later third) is battery-to-inverter (and metering)
    //up to +/- 5A ::
    current[1] = (v[1] - 2.5)/0.168;        //calibrated
    current[2] = (v[2] - 2.525)/ 0.185;       //0.185V/A
  
    Serial.print("battery_mains_current_A: ");
    Serial.println(current[1]);
    Serial.print("battery_mains_voltage_V: ");
    V_battery = Vratio*(v[4]);
    Serial.println(V_battery);           
    //energy[0] += V_panels*current[0]*time_interval/3600;  //energy from panels
    for (int i=1; i<3 ; i++){       // energy from battery
      energy[i] += V_battery*current[i]*time_interval/60/60;        //time_interval
    }
    Serial.println("----------------------------");
    then = now;
    
    //loop to send out data
    if ((now-sendtime) >= sendtime_interval){
      Serial.print("mAH consumed by inverter: ");
      Serial.println(energy[1]);
      Serial.println("----------------------------");
      //clear out energy array
      for (int i=0; i<3; i++){
        energy[i] = 0;
      }
      sendtime = now;
    }
  }
  
}
