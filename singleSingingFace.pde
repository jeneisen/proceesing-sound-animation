import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;

float s_volume;
float volume;
float v, v2;
float easing = 0.2;
float x;
float y;
float rot = 1,diameter=60; 

// these are all defined on the first page, if that makes any difference.

PFont font;

void setup() {
  size(600, 600);
  smooth();
  font=loadFont("U.S.101-48.vlw");
  setup_volume();
}

void draw() {
  background(79, 187, 200);
  get_volume(); // call to function that gets volume amplitude

  v=map(volume, 0, 50, 0, width); //map v to 0-600, may need adjustment
  v=constrain(v,0,600); //constrains the variable v btw 0-600
  
  ////PASTE YOUR CODE FROM YOUR DRAW FUNCTION HERE

  //v=mouseX;
    float mouthopen=constrain(v, 140, 280);
    float mouthside=constrain(v, 120, 175);
    float mouthopen2=constrain(v, 60, 210);
    float mouthside2=constrain(v, 60, 145);
    
//    background(79, 187, 200);
//    background(79, 145+v/2, 200);
    for(int i=0; i<=width; i+=40) {
       for(int j=0; j<=width; j+=40) {
         float size=v;
         size = 50-(size*=.1);
         if(size<0) {
             fill(255);
         }
         ellipse(i,j,size,size);
       }
     }
    
    //cloud base
    noStroke();
    fill(80+v/2);
    translate(width/9, height/9);
    //huge main ellipse
    ellipse(60, 40, 160+v/10, 160+v/10);
    // bottom corner
    ellipse(80, 100, 90+v/10, 90+v/10);
    ellipse(150, 200/2, 100+v/15, 100+v/15);
    ellipse(0, 200/2, 100+v/10, 100+v/10);
    //upper right ellipses
    ellipse(140, -10, 95+v/10, 95+v/10);
    ellipse(150, 40, 95+v/10, 95+v/10);
    //ellipses further out right side
    ellipse(200, 20, 80+v/15, 90+v/15);
    ellipse(200, 70, 70+v/10, 70+v/10);
  
    //sunshine rays!!!
    for (int i=0; i< 200;i++) {
     stroke(246, 129, 0);
     strokeWeight(4);
     line(350,280,v*cos((PI/50)*i)+300,v*sin((PI/50)*i)+300);
    }
    
      
    //osciliating second huge circle
//    x+=3*sin(radians(rot));
//    y+=5*cos(radians(rot));
//    rot+=45;
//    fill(255,246,64);
    noStroke();
//    ellipse(300+x,300+y,320,320);
    
    
    //sun cirlce head base
    fill(255,246,64);
    ellipse(300,300,300,300);
    
    //mouth
    noStroke();
    //actual orange ellipse part
    fill(255, 96, 2);
    arc(300, 310, mouthside, mouthopen, 0, PI);
    //smaller inside mouth part random flicker
    fill(random(180, 255), random(50, 96), random(40, 64));
    arc(300, 310, mouthside2, mouthopen2, 0, PI);
   
   //ellipse covering bottom ellipse 
    fill(255,246,64);
    arc(300, 325, 185, 90, 0, TWO_PI); 

    
    //eyes
    float w = map(v, 0, width, 20, 70);
    float e = map(v, 0, width, 20, 70);
    //white big
    fill(255);
    ellipse(240,250,40+(w*2),40+(e*2));
    ellipse(360,250,40+(w*2),40+(e*2));
    //blue moon shaped pupil (really just hidden)
    fill(#56A5EC);
    ellipse(240,250,30+w,30+e);
    ellipse(360,250,30+w,30+e);
    fill(255);
    //white small 
    ellipse(250,235,12+w,12+e);
    ellipse(370,235,10+w,10+e);
  
   
 

  ///////////////////////////////////////

  //credits
  fill(150);
  textFont(font, 14);
  textAlign(CENTER);
  String credits = "Bruce Wayne";
  text(credits, width/2, height-10);
  fill(255);


}


void setup_volume() {
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 1024, 44100);
  }

void get_volume() {
  s_volume=in.mix.level()*100;
  float d_volume = s_volume - volume;
  if (abs(d_volume) > 1) {
    volume += d_volume * easing;
  }
  println("volume="+ volume);
}


void stop() {
  in.close();
  minim.stop();
  super.stop();
}

