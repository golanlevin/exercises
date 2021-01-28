
PImage cursorImg; 
float py;
float px;
float pradius;  

float xspeed = 7;
float yspeed = 5;


void setup() {
  size(800, 800);

  py = 123;
  px = 117; 
  pradius = 50;
  fill(253, 253, 253);
}

void draw() {
  // background(253); 
  float alp = (mousePressed) ? 255: 20; 
  rectMode(CORNER); 
  fill(253, 253, 253, alp); 
  noStroke(); 
  rect(0,0, width+1, height+1); 

  fill(0, 0, 0);
  noStroke();
  ellipse(px, py, pradius*2, pradius*2);

  px = px + xspeed;
  py = py + yspeed;
  float pL = px - pradius; 
  float pR = px + pradius; 
  float pT = py - pradius; 
  float pB = py + pradius; 

  if ((pL<0) || (pR>width)){
    xspeed = xspeed*-1;
  }

  if ((pT<0) || (pB>height)) {
    yspeed = yspeed*-1;
  }

}


void keyPressed(){
  if (key == ' '){
    saveFrame("bouncing_ball.png"); 
  }
}
