void setup() {
  size(800, 800, FX2D);
}


void draw() {

  background(55, 70, 120); 

  noStroke(); 
  int nStars = 200; 
  randomSeed(0); 
  for (int i=0; i<nStars; i++) {
    float sy = random(0, height);
    float sx = map(i, 0, nStars, 0, width);
    fill(255, random(220, 255), random(220, 255)); 
    float radius = random(2, 8); 
    ellipse(sx, sy, radius, radius);
  }

  int nBuildings = 9;
  for (int i=0; i<nBuildings; i++) {
    float sy = map(noise(i/15.0+(millis()/5000.0)), 0.1, 0.9, 0.0, height); 
    float sx = map(i, 0, nBuildings, 0, width);
    fill(253); 
    rect(sx, height, (float)width/nBuildings+1, 0-sy); 
    rect(sx, height-sy-240, (float)width/nBuildings+1, -800);
  }

  stroke(0); 
  strokeWeight(8); 
  strokeJoin(MITER); 
  fill(255); 
  triangle(width/2-90, mouseY-40, width/2-70, mouseY+40, width/2+70, mouseY+20);
}

void keyPressed() {
  if (key==' ') {
    saveFrame("whistleCursor_#####.jpg");
  }
}
