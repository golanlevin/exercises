void setup() {
  size(800, 800, FX2D); 
  smooth();
}

void draw() {
  background (253); 
  strokeWeight(8); 
  strokeCap(SQUARE);
  stroke(0); 

  //sets amount of lines being drawn
  int nLines = 8;
  //sets margin
  float margin = 50; 

  for (int i=0; i<nLines; i++) {
    //line always starts with the same x value
    float x0 = margin; 
    //line always ends with the same y value
    float y1 = height - margin; 
    //makes the lines starting y values equidistant
    float y0 = map(i, 0, nLines-1, margin, height-margin);
    float x1 = y0; 
    line (x0, y0, x1, y1);
  }

  line(margin-4, height - margin, margin, height - margin);
}

void mousePressed() {
  if (key == ' ') {
    saveFrame("string_art_challenge.png");
  }
}
