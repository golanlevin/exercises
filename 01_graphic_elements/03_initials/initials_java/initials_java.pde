

void setup() {
  size(800, 800);
  background(253);
  smooth();
  
  fill(0); 
  stroke(0);
  strokeWeight(5);
  strokeCap(SQUARE); 
  
  pushMatrix(); 
  scale(8.0/3.0, 8.0/3.0); 
  
  float w = 300; 
  line(w/4+20, 120, w/4+20, 240);
  line(3*w/4-40, 50, 3*w/4-40, 240);
  noStroke();
  arc(w/4+20, 110, 120, 120, PI, TWO_PI, OPEN);
  arc(3*w/4-30, 100, 100, 100, -1*HALF_PI, HALF_PI, OPEN);
  arc(3*w/4-30, 190, 100, 100, -1*HALF_PI, HALF_PI, OPEN);
  popMatrix(); 
}

void draw() {
}

void keyPressed() {
  saveFrame("initials.png");
}
