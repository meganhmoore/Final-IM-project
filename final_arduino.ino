boolean buttonDown1=false;
boolean buttonDown2=false;
boolean buttonDown3=false;
boolean buttonDown4=false;
boolean buttonDown5=false;

void setup() {
  pinMode(A0, INPUT_PULLUP);
  pinMode(A1, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  float val=analogRead(A0);
  float val1=analogRead(A1);
  Serial.println(analogRead(A1));
  if(val<900){
    if(!buttonDown1){
      Serial.println("4");
      buttonDown1=true;
    }else{
      buttonDown1=false;
    }
  }
  if(val1<900){
    if(!buttonDown2){
      Serial.println("5");
      buttonDown2=true;
    }else{
      buttonDown2=false;
    }
  }
}
