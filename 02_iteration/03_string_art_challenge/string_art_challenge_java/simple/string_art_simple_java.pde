void setup() {
  size(400, 400); 
  smooth();
}

void draw() {
  background (255); 
  stroke(0); 
  strokeWeight (1.5); 

  int nLines = 7;
  float margin = 50; 
  for (int i=0; i<=7; i++) {
    float x0 = margin; 
    float y1 = height - margin; 
    float y0 = map(i, 0, nLines, margin, height-margin);
    float x1 = y0; 
    line (x0, y0, x1, y1);
  }
}

void mousePressed() {
  saveFrame("string_art_simple.png"); 
  exit();
}