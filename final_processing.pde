import processing.serial.*;
import processing.sound.*;

Serial myPort;
SoundFile file;
float mess;
int height=800;
int width=800;
int moon=400;
int count1=0;  
int count2=0;
int count5=0;

boolean led1=false;
boolean led2=false;
boolean led3=false;
boolean led4=false;
boolean led5=false;
boolean onLight=true;

ArrayList<Twinkle> twinkleArrayOne;
ArrayList<Twinkle> twinkleArrayTwo;
ArrayList<ShootingStar> starArrayThree;

void setup(){
  size(height,width);
  file = new SoundFile(this, "moonMusic.mp3");
  file.play();
  fill(255);
  noStroke();
  background(0);
  textAlign(CENTER);
  textSize(32);
  String portName="/dev/tty.usbserial-DN01DNHV";
  myPort=new Serial (this, portName, 9600);
  myPort.bufferUntil('\n');
  
  twinkleArrayOne= new ArrayList<Twinkle>();
  twinkleArrayTwo= new ArrayList<Twinkle>();
  starArrayThree=new ArrayList<ShootingStar>();
  
  for(int i=0; i<100; ++i){
    int randX=(int)random(0,width);
    int randY=(int)random(0,height);
    Twinkle t= new Twinkle(true, 10,randX, randY,9);
    twinkleArrayOne.add(t);
  }
  for(int i=0; i<50; ++i){
    int randX=(int)random(0,width);
    int randY=(int)random(0,height);
    Twinkle t= new Twinkle(true, 10,randX, randY,9);
    twinkleArrayTwo.add(t);
  }
  for(int i=0; i<25; ++i){
    float randX=random(0,width-200);
    float randFrame=random(10,200);
    ShootingStar s=new ShootingStar(i*30+randX, i*10+80, 5,10,5,randFrame);
    starArrayThree.add(s);
  }
    
}
void draw(){
  background(0);
  int addStars=(int) random(1,10);
  if(addStars==10){
    int randX=(int)random(0,width);
    int randY=(int)random(0,height);
    Twinkle t= new Twinkle(true, 10,randX, randY,9);
    twinkleArrayOne.add(t);
  }
  //if(led4==true){
    //if(moon<300){
    //  moon++;
    //}
    fill(255);
    ellipse(moon+20,moon,300,300);
    fill(0);
    ellipse(moon+130,moon,300,300);
    strokeWeight(3);
    noFill();
    stroke(0);
    arc(360,330,35,30,0,PI);
    
    
    if(count5<100){
      fill(255);
      text("Good Night Moon",width/2,height/2);
      count5++;
    }
  //}
  if(mess==2.0){
    for(int i=0; i<twinkleArrayOne.size();i++){
      Twinkle t=twinkleArrayOne.get(i);
      int twinkle=(int)random(1,20);
      if(twinkle==3){
        t.count=0;
        t.twinkleOn=false;
        t.display();
      }else if(t.count<8){
        t.twinkleOn=false;
        t.display();
        t.count++;
      }
      else{
        t.count=9;
        t.twinkleOn=true;
        t.display();
      }
    }
    if(count2<100){
      text("Good Night Stars",width/2,height/4);
      count2++;
    }
  }
  if(mess==3.0){
    for(int i=0; i<twinkleArrayTwo.size();i++){
      Twinkle t=twinkleArrayTwo.get(i);
      int twinkle=(int)random(1,20);
      if(twinkle==3){
        t.count=0;
        t.twinkleOn=false;
        t.display();
      }else if(t.count<8){
        t.twinkleOn=false;
        t.display();
        t.count++;
      }
      else{
        t.count=9;
        t.twinkleOn=true;
        t.display();
      }
    }
  }
  if(led3==true){
    for(int i=0; i<starArrayThree.size(); i++){
      ShootingStar s=starArrayThree.get(i);
      s.starDraw();
    }
    if(count1<100){
      text("Good Night Shooting Stars",width/2,height*3/4);
      count1++;
    }
  } 
}
void serialEvent(Serial myPort){
  String message=myPort.readString();
  println(message);
  mess=float(message);
  println(mess);
  if(mess==2.0){
    led1=true;
  }else if(mess==3.0){
    led2=true;
  }else if(mess==4.0){
    led3=true;
  }else if(mess==5.0){
    led4=true;
  }
  
}
class Twinkle{
  int width1;
  boolean twinkleOn;
  int x;
  int y;
  int count;
  
  Twinkle(boolean on, int widthOne, int xPos, int yPos, int tCount){
    width1=widthOne;
    twinkleOn=on;
    x=xPos;
    y=yPos;
    count=tCount;
  }
  
  void display(){
    fill(255);
    strokeWeight(1);
    stroke(255);
    if(this.twinkleOn==true){
      ellipse(x,y,width1-3, width1-3);
      line(x-8,y,x+8,y);
      line(x,y-8,x,y+8);
      
    }
    else{
      ellipse(x,y,width1-5,width1-5);
      line(x-5,y,x+5,y);
      line(x,y-5,x,y+5);
      
    }
    noStroke();
  }
}
class ShootingStar{
  float thisX;
  float thisY;
  float radiusOne;
  float radiusTwo;
  int numPoints;
  float frame;
  
  ShootingStar(float x, float y, float radius1, float radius2, int npoints, float frameR){
    thisX=x;
    thisY=y;
    radiusOne=radius1;
    radiusTwo=radius2;
    numPoints=npoints;
    frame=frameR;
  }
    
  
  
  void starDraw() {
    pushMatrix();
    translate(width*0.9, height*0.5);
    rotate(frameCount / -(this.frame));
    star(this.thisX, this.thisY, this.radiusOne, this.radiusTwo, this.numPoints); 
    popMatrix();
  }
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    fill(200,200,100);
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
    
  }
}