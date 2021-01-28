PVector A1; 
PVector A2; 
PVector B1; 
PVector B2; 

PImage cursorImg;
PFont myFont; 

float dot_diameter = 24;
float color_dot_diameter = 32;

void setup() {
  size(800, 800); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);
  
  reset();
}

void draw() {
  background(253); 
  stroke(0); 
  
  rectMode(CORNERS); // the first two parameters of rect() as the location of one corner, and the third and fourth parameters as the location of the opposite corner

  // draw two rectangles
  noFill();
  strokeWeight(8);
  rect(A1.x, A1.y, A2.x, A2.y);
  rect(B1.x, B1.y, B2.x, B2.y);
  
  PVector A_mid = new PVector((A1.x + A2.x)/2, (A1.y + A2.y)/2);
  PVector B_mid = new PVector((B1.x + B2.x)/2, (B1.y + B2.y)/2);
  intersect(A1, A2, B1, B2);
    
  //if (intersect(A1, A2, B1, B2)) {
  //  // draw line connecting the two midpoints
  //  line(A_mid.x, A_mid.y, B_mid.x, B_mid.y);
          
  //  // draw midpoints
  //  fill(0, 255, 0);
  //  ellipse(A_mid.x, A_mid.y, color_dot_diameter, color_dot_diameter);
  //  fill(255, 50, 50);
  //  ellipse(B_mid.x, B_mid.y, color_dot_diameter, color_dot_diameter);

  //}
}

void mousePressed() {
  reset();
}

// Returns true if two rectangles (l1, r1) and (l2, r2) overlap 
boolean intersect(PVector l1, PVector r1, PVector l2, PVector r2) {
  
  // If one rectangle is on left side of other 
    if (l1.x >= r2.x || l2.x >= r1.x) 
        return false; 
  
  // If one rectangle is above other 
  if (l1.y >= r2.y || l2.y >= r1.y) 
      return false;
  
  PVector corner1 = new PVector(max(l1.x, l2.x), max(l1.y, l2.y));
  PVector corner2 = new PVector(min(r1.x, r2.x), min(r1.y, r2.y));
  strokeWeight(3);
  line(corner1.x, corner1.y, corner2.x, corner2.y);
  line(corner1.x, corner2.y, corner2.x, corner1.y);
  
      
  //// there is an overlap
  //if (l1.x < r2.x) {
  //  if (l1.y < r2.y) {
  //    line(l2.x, l2.y, r1.x, r1.y);
          
  //    //fill(0, 255, 0);
  //    //ellipse(l1.x, l1.y, color_dot_diameter, color_dot_diameter);
  //    //fill(255, 50, 50);
  //    //ellipse(r2.x, r2.y, color_dot_diameter, color_dot_diameter);
  //  } else {
  //    line(r1.x, l1.y, l2.x, r2.y);    
  //  }
  //} else {
  //  if (l1.y < r2.y) {
  //    line(l1.x, l1.y, r2.x, r2.y);
  //  } else {
  //    line(r2.x, l2.y, l1.x, r1.y);
  //  }
  //}
  return true;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("intersection_of_two_rectangles.png");
  } else {
    reset();
  }
}

void reset() {
  //A1 = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  //A2 = new PVector(random(A1.x+10, width*0.9), random(A1.y+10, height*0.9), 0); 
  //B1 = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
  //B2 = new PVector(random(B1.x+10, width*0.9), random(B1.y+10, height*0.9), 0); 
  A1 = new PVector(120, 100); 
  A2 = new PVector(500, 420); 
  B1 = new PVector(250, 250);
  B2 = new PVector(650, 700); 
  //print(A1, A2, B1, B2);
  //print("\n");
}
