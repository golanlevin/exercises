int x = -100;
float timeStarted = 0;
float progress = 0.0;

void setup() {
  size(800, 800);
}

void draw() {
  background(253);
  
  if (mousePressed){
    timeStarted = millis(); 
  }
  progress = constrain((millis() - timeStarted)/5000.0, 0, 1);
  
  if (progress < 1.0){
    pushMatrix(); 
    scale(8.0/3.0); 
    drawBar();
    if (progress > 0.001) {
      drawFire();
    }
    popMatrix(); 
    
  } else if (progress >= 1.0){
    // "Explosion"
    int j = (millis()/100)%4;
    for (int i=0; i<8; i++){
      ellipseMode(CENTER); 
      color yelCol = color(255,255,0); 
      color redCol = color(255,0,0);
      float t = map((i+j)%5, 0,4, 0,1);
      fill(lerpColor(yelCol, redCol, t));
      int d = (8-i) * (width/5);
      ellipse(width/2, height/2, d,d);
    }
  }
}

void drawBar() {
  rectMode(CENTER);
  noStroke();
  fill(0);
  rect(300/2, 300/2, 250, 10);
  smooth();
  
  rectMode(CORNER);
  fill(180);
  
  float l = map(progress, 0, 1, 0, 250);
  rect(25, 300/2-5, l, 10);
}


void drawFire() {
  float move = map(progress, 0.0, 1.0, -250, 0);
  
  fill(#FFB936);
  pushMatrix();
  
  translate(move, 40);
  bezier(260, 38, 226, 169, 362, 109, 254, 35);

  fill(#FF8258);
  scale(0.7);
  translate(120, 50);
  bezier(260, 38, 226, 169, 362, 109, 254, 35);
  //ellipse(width/2+x, height/2, 20, 20);
  popMatrix();
}

void mousePressed() {
  timeStarted = millis();
}

void keyPressed() {
  // saveFrame("fuse.png");
}
