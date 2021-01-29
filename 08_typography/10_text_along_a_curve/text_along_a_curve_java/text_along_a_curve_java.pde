// Text along a (Bezier) curve.

// See, for reference: 
// https://processing.org/reference/bezierPoint_.html
// https://processing.org/reference/curvePoint_.html

PFont myFont;   
PVector ctrlPts[]; 

void setup() {
  size(800, 800); 
  myFont = createFont("BirchStd", 72);
  
  ctrlPts = new PVector[4]; 
  ctrlPts[0] = new PVector(90, 95); 
  ctrlPts[1] = new PVector(265, 45);
  ctrlPts[2] = new PVector(155, 315);
  ctrlPts[3] = new PVector(355, 360);
  
  ctrlPts[0].mult(2);
  ctrlPts[1].mult(2);
  ctrlPts[2].mult(2);
  ctrlPts[3].mult(2);
}


void draw() {
  background(253); 
  
  float ax = ctrlPts[0].x;
  float ay = ctrlPts[0].y;
  float bx = ctrlPts[1].x;
  float by = ctrlPts[1].y;
  float cx = ctrlPts[2].x;
  float cy = ctrlPts[2].y; 
  float dx = ctrlPts[3].x; 
  float dy = ctrlPts[3].y; 
  
  // From https://www.azquotes.com/quotes/topics/curves.html
  // "Magic lives in curves, not angles." -- Mason Cooley
  String phrase = "magic lives in curves";

  noFill(); 
  stroke(200); 
  strokeWeight(2);
  bezier(ax, ay, bx, by, cx, cy, dx, dy);
  
  noStroke(); 
  fill(0,0,0); 
  textFont(myFont);
  textAlign(CENTER); 
  
  int nChars = phrase.length();
  for (int i = 0; i < nChars; i++) {
    
    // First, calculate the position of the i'th letter. 
    float u = map(i, 0, nChars-1, 0,1); 
    float px = bezierPoint(ax, bx, cx, dx, u);
    float py = bezierPoint(ay, by, cy, dy, u);
     
    // We need a second point to calculate the local slope.
    float v = u + 0.01;
    float qx = bezierPoint(ax, bx, cx, dx, v);
    float qy = bezierPoint(ay, by, cy, dy, v);
    float tx = qx - px; 
    float ty = qy - py; 
    float orientation = atan2(ty, tx); 
    
    // Fetch the i'th letter
    char ithChar = phrase.charAt(i);
    
    // Render it at the position, with the orientation. 
    pushMatrix(); 
    translate(px, py); 
    rotate(orientation); 
    text(ithChar, 0,-5); 
    popMatrix(); 
  }
}


void keyPressed() {
  saveFrame("type_along_a_curve.png");
}
