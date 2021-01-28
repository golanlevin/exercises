PVector A; 
PVector B; 
PVector C;

PImage cursorImg;
PFont myFont; 

void setup(){
  size(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);
  
  reset();
}

void draw() {
  background(253);
  
  stroke(0);
  strokeWeight(8);
  
  // draw triangle
  line(A.x, A.y, B.x, B.y);
  line(A.x, A.y, C.x, C.y);
  line(C.x, C.y, B.x, B.y);
  
  drawOrthoCenter();
}

void drawOrthoCenter() { 
  PVector CDrop = drawPerpendicularLine(A, B, C);
  PVector BDrop = drawPerpendicularLine(C, A, B);
  PVector ADrop = drawPerpendicularLine(C, B, A);
  
  // find the intersection between two of the "altitudes"
  PVector P1 = A; 
  PVector P2 = ADrop;
  PVector P3 = B;
  PVector P4 = BDrop;
  float ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  float ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x))/((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  float x = P1.x + ua * (P2.x-P1.x);
  float y = P1.y + ua * (P2.y-P1.y);
  
  ellipseMode(CENTER); 
  
  fill(0); 
  strokeWeight(8);

  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(C.x, C.y, 24, 24); 
  
  fill(0, 255, 0);
  ellipse(x, y, 32, 32);
 
}


// draw perpendicularLine from P3 to line segment P1-P2
// return the coordinates of the point where the altitude crosses the opposite side
PVector drawPerpendicularLine(PVector P1, PVector P2, PVector P3) {
    // http://paulbourke.net/geometry/pointlineplane/
  float numer = ((P3.x-P1.x)*(P2.x-P1.x) + (P3.y-P1.y)*(P2.y-P1.y));
  float denom = ((P2.x-P1.x)*(P2.x-P1.x) + (P2.y-P1.y)*(P2.y-P1.y));
  float u = numer / denom; 
  
  float px = P1.x + u*(P2.x - P1.x);
  float py = P1.y + u*(P2.y - P1.y);
  PVector pPerp = new PVector(px, py);
  
  line(px, py, P3.x, P3.y);
  drawSquare(pPerp, P3);
  
  return pPerp;
}

void drawSquare(PVector p0, PVector p1) {
  float slope = (p0.y - p1.y)/(p0.x - p1.x);
  float rad = atan(slope);
  if (p1.x - p0.x < 0) {
    rad += PI;
  }
  
  pushMatrix();
  translate(p0.x, p0.y);
  rotate(rad);
  noFill();
  strokeWeight(2);
  rect(0, 0, 30, 30);
  popMatrix();
}


void mousePressed() {
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("orthocenter_of_triangle.png");
  } else {
    reset();
  }
}

void reset() {
  //A = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  //B = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  //C = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  A = new PVector(191, 115, 0); 
  B = new PVector(141, 699, 0); 
  C = new PVector(694, 286, 0);
}
