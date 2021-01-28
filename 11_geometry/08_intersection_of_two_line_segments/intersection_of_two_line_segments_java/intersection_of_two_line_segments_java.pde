// Intersection point of two line segments. 

PVector P1; 
PVector P2; 
PVector P3; 
PVector P4; 

//------------------------------------
void setup() {
  size(800, 800);
  reset(); 
}

//------------------------------------
void draw() {
  background(253);

  // Draw the 4 points.
  noStroke(); 
  fill(0); 
  ellipse(P1.x, P1.y, 24, 24);
  ellipse(P2.x, P2.y, 24, 24); 
  ellipse(P3.x, P3.y, 24, 24); 
  ellipse(P4.x, P4.y, 24, 24); 

  // Draw the lines. 
  stroke(0); 
  strokeWeight(8);
  line(P1.x, P1.y, P2.x, P2.y); 
  line(P3.x, P3.y, P4.x, P4.y); 

  // Check if they intersect
  // Ref: http://paulbourke.net/geometry/pointlineplane/
  float denominator = ((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y));
  float ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x)) / denominator;
  float ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x)) / denominator;
  if (ua < 0 || ub < 0 || ua > 1 || ub > 1) {
    // the line segments don't intersect
    ;
  } else {
    // Find intersection point
    float x = P1.x + ua * (P2.x-P1.x);
    float y = P1.y + ua * (P2.y-P1.y);

    // Draw intersection point. 
    fill(0, 255, 0);
    ellipse(x, y, 32, 32);
  }
}

//------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("intersection_of_two_line_segments.png");
  }
}

//------------------------------------
void mousePressed() {
  reset();
}

//------------------------------------
void reset() {
  P1 = new PVector(random(width), random(height));
  P2 = new PVector(random(width), random(height));
  P3 = new PVector(random(width), random(height));
  P4 = new PVector(random(width), random(height));
}
