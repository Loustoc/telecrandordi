import processing.serial.*;
import cc.arduino.*;

Arduino arduino; //creates arduino object
PImage img;
PImage pot1;
PImage pot2;

int sensor= 0;
int sensor2= 1;

int read=0;
int read2=0;
float prev=0;
float prev2=0;
float value1=0;
float value2=0;
int temp=-1;
void setup() {;
img = loadImage("telecran_ameliore.PNG");
pot1 = loadImage("potentiometre1.png");
pot2 = loadImage("potentiometre2.png");

  size(669, 791);
image(img, 0, 0, 669, 791);
  arduino = new Arduino(this, Arduino.list()[0], 57600); //sets up arduino
    arduino.pinMode(sensor, Arduino.INPUT);//setup pins to be input (A0 =0?)
    arduino.pinMode(sensor2, Arduino.INPUT);//setup pins to be input (A1 =1?)
}
void draw() {
    stroke(100);
if(temp==-1){
  read=arduino.analogRead(sensor);
  read2=arduino.analogRead(sensor2);
    prev=abs(read-1023);
  prev2=abs(read2-1023);
temp=0;

}
if(temp==0){
  read=arduino.analogRead(sensor);
  read2=arduino.analogRead(sensor2);
  value1=abs(read-1023);
  value2=abs(read2-1023);
  line(map(value1,0,1023,94.66,580.66), map(value2,0,1023,104.66,579.32), map(prev,0,1023,94.66,580.66), map(prev2,0,1023,104.66,579.32));
temp++;
potrot();
}
if(temp==1){temp--;
  read=arduino.analogRead(sensor);
  read2=arduino.analogRead(sensor2);

  prev=abs(read-1023);
  prev2=abs(read2-1023); 
   };}
void potrot(){
  pushMatrix();
translate(85, 705);
imageMode(CENTER);
rotate(radians(map(value1,0,1023,0,360)));
image(pot1, 0, 0, 171.33, 170);
popMatrix();
  pushMatrix();
translate(589, 710);
  imageMode(CENTER);
rotate(radians(map(value2,0,1023,0,360)));
  image(pot2, 0, 0, 174, 174);
  popMatrix();
    resetMatrix();

}
void mouseClicked(){
  imageMode(CORNER);
  temp=0;
 image(img, 0, 0, 669, 791);

}
void keyPressed(){
save("telecrandordi.png");
}
