
PImage cursorImg; 
float py;
float px;
float pradius;  

float xspeed = 5;
float yspeed = 5;


void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 

  py = 50;
  px = 50; 
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

  
  
  rectMode(CENTER);

  fill(0, 0, 0);
  noStroke();
  ellipse(px, py, pradius*2, pradius*2);

  float rX = 0.75*width;
  float rW = 40; 
  float rH = 200; 
  float rL = rX - rW/2; 
  float rR = rX + rW/2; 
  float rT = mouseY - rH/2; 
  float rB = mouseY + rH/2; 
  rect(rX, mouseY, rW, rH);

  px = px + xspeed;
  py = py + yspeed;

  //CONDITIONAL STATEMENTS
  float pL = px - pradius; 
  float pR = px + pradius; 
  float pT = py - pradius; 
  float pB = py + pradius; 

  if ((pL<0) || (pR>width) || ((pB > rT) && (pT < rB) && (((pR > rL)&&(pL < rL))  || ((pL < rR)&&(pR > rR))) ) ) {
    xspeed = xspeed*-1;
  }

  if ((pT<0) || (pB>height)) {
    yspeed = yspeed*-1;
  }
  

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


void keyPressed(){
  if (key == ' '){
    saveFrame("one_person_pong.png"); 
  }
}
