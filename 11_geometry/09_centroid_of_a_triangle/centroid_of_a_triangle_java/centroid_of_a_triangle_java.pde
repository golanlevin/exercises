PVector A; 
PVector B; 
PVector C;

PImage cursorImg;
PFont myFont; 

void setup() {
  size(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);

  A = new PVector(191, 115, 0); 
  B = new PVector(141, 699, 0); 
  C = new PVector(694, 286, 0);
}



void draw() {
  background(253);

  stroke(0);
  strokeWeight(8);

  // draw triangle
  line(A.x, A.y, B.x, B.y);
  line(A.x, A.y, C.x, C.y);
  line(C.x, C.y, B.x, B.y);

  drawCentroid();
}

void drawCentroid() {

  PVector AB_mid = new PVector((A.x + B.x)/2, (A.y + B.y)/2);
  PVector BC_mid = new PVector((C.x + B.x)/2, (C.y + B.y)/2);
  PVector CA_mid = new PVector((A.x + C.x)/2, (A.y + C.y)/2);

  strokeWeight(2);
  line(A.x, A.y, BC_mid.x, BC_mid.y);
  line(AB_mid.x, AB_mid.y, C.x, C.y);
  line(CA_mid.x, CA_mid.y, B.x, B.y);

  ellipseMode(CENTER); 
  strokeWeight(8);

  fill(0); 
  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 

  // draw centroid
  PVector centroid = new PVector((A.x + B.x + C.x)/3, (A.y + B.y + C.y)/3);
  fill(0, 255, 0);
  ellipse(centroid.x, centroid.y, 32, 32); 

  // draw tick marks
  drawTick(B, AB_mid, 1);
  drawTick(AB_mid, A, 1);
  drawTick(A, CA_mid, 2);
  drawTick(CA_mid, C, 2);
  drawTick(B, BC_mid, 3);
  drawTick(BC_mid, C, 3);
}

void drawTick(PVector p1, PVector p2, int n) {
  strokeWeight(2);
  float tickLen = 20;
  
  PVector midpoint = p1.copy().add(p2).div(2);
  float slope = (p2.y-p1.y)/(p2.x-p1.x);
  float rad = atan(slope);
  float tickRad = atan(-1/slope);
  
  for (int i = 0; i < n; i++) {
    float x = midpoint.x + (i-n/2)*tickLen/2*cos(rad);
    float y = midpoint.y + (i-n/2)*tickLen/2*sin(rad);
    line(x-cos(tickRad)*tickLen, y-sin(tickRad)*tickLen, x+cos(tickRad)*tickLen, y+sin(tickRad)*tickLen);
  }
}

void mousePressed() {
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("centroid_of_a_triangle.png");
  } else {
    reset();
  }
}

void reset() {
  A = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  B = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  C = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
}
