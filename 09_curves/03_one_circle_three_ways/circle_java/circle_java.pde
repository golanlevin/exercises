void setup() {
  size(800, 800);
}

void draw() {
  background(253);
 
  int nPoints = 20;
  float radius = 300;
  float separation = 125;
  
  // draw the circle normally
  pushMatrix();
  translate(width/2, height/2);
  noFill();
  stroke(0); 
  strokeWeight(8);
  beginShape();
  for (int i = 0; i < nPoints; i++) {
    float theta = map(i, 0, nPoints, 0, TWO_PI);
    float px = radius * cos(theta);
    float py = radius * sin(theta);
    vertex(px, py); 
  }
  endShape(CLOSE);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height /2);
  for (int i = 0; i < nPoints; i++) {
    float theta = map(i, 0, nPoints, 0, TWO_PI);
    float px = radius * cos(theta);
    float py = radius * sin(theta);
    // fill(255, 200, 200);
    // ellipse(px, py, 32, 32);
    fill(0); 
    noStroke();
    ellipse(px, py, 24,24);
  }
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("circle.png");
  }
}
