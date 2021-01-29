import processing.sound.*;
AudioIn in;
Amplitude amp;

float r =  500;

void setup() {
  size(800, 800);
  
  strokeCap(ROUND);
  ellipseMode(CENTER);

  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  in.start();
  amp.input(in);
}

void draw() {
  background(253);
  
  float volume = amp.analyze();
  //println(volume);
  float move = constrain(map(volume, 0, 0.1, 0, 100), 0, 100);
  
  drawFace();
  drawMouth(move);
}

void drawFace() {
  stroke(0);
  strokeWeight(16);
  fill(253, 235, 43);
  
  // face
  ellipse(width/2, height/2, r, r);
  
  // eyes
  fill(0);
  ellipse(width/2-100, height/2-height/16, width/16, width/16);
  ellipse(width/2+100, height/2-height/16, width/16, width/16);
  
  float r1 = PI/8;
  float r2 = PI*15/16;
  float r3 = PI*9/8;
  float r4 = PI*7/4;
  float l1 = width/2 - 95;
  float l2 = width/2 - 50;
  line(width/2+cos(r1)*l1, height/2+sin(r1)*l1, width/2+cos(r1)*(l2-10), height/2+sin(r1)*(l2-10));
  line(width/2+cos(r2)*l1, height/2+sin(r2)*l1, width/2+cos(r2)*l2, height/2+sin(r2)*l2);
  line(width/2+cos(r3)*(l1+5), height/2+sin(r3)*(l1+5), width/2+cos(r3)*(l2+20), height/2+sin(r3)*(l2+20));
  line(width/2+cos(r4)*(l1+10), height/2+sin(r4)*(l1+10), width/2+cos(r4)*(l2+25), height/2+sin(r4)*(l2+25));
}

void drawMouth(float move) {
  
  float up = 200;
  
  float left_a =  HALF_PI-0.15*PI;
  float right_a = HALF_PI+0.15*PI;
  
  pushMatrix();
  translate(0, move);
  
  noStroke();
  fill(253, 235, 43);
  rect(width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2-up+5, r/2 * sin(0.15*PI) * 2, up);
  fill(232,90,71);
  rect(width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2-up+5, r/2 * sin(0.15*PI) * 2, up/2);
  fill(255);
  rect(width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2-up+5, r/2 * sin(0.15*PI) * 2, up/4);
  
  stroke(0);
  strokeWeight(16);
  fill(253, 235, 43);
  arc(width/2, height/2, r, r, left_a, right_a, OPEN);
  fill(232,90,71);
  arc(width/2, height/2-up/2, r, r, left_a, right_a, OPEN);
  fill(255);
  arc(width/2, height/2-up*3/4, r, r, left_a, right_a, OPEN);
  fill(253, 235, 43);
  arc(width/2, height/2-up, r, r, left_a, right_a, OPEN);
  line(width/2+cos(left_a)*r/2, height/2+sin(left_a)*r/2, width/2+cos(left_a)*r/2, height/2+sin(left_a)*r/2-up);
  line(width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2, width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2-up);
  
  noFill();
  arc(width/2+cos(right_a)*r/2, height/2+sin(right_a)*r/2, 80, 80, HALF_PI, PI);
  
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("audio_sensitive.png");
  }
}
