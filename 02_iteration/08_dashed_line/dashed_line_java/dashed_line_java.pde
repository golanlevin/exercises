// Dashed line
PImage cursorImage; 

void setup() {
  size(800, 800);
  cursorImage = loadImage("cursor_with_shadow_15x21.png"); 
  smooth(); 
}

void draw() {
  background(253); 

  //these x and y values represent the line from the point to your cursor
  float x0 = width * 0.75;
  float y0 = height * 0.25;
  float x1 = mouseX;
  float y1 = mouseY; 

  float dashLength = 80.0; 
  float lineLength = dist(x0, y0, x1, y1); 
  float nDashesf = (lineLength / dashLength);

  fill(0); 
  noStroke(); 
  ellipse(x0, y0, 20, 20); 

  stroke(0); 
  strokeWeight(8);
  //splits the calculated line into multiple lines, making dashes
  for (int i=0; i<nDashesf; i++) {
    float percentA = map(i+0.0, 0, nDashesf, 0, 1);
    float percentB = map(min(i+0.55, nDashesf), 0, nDashesf, 0, 1);

    float dashXa = map(percentA, 0, 1, x0, x1); 
    float dashYa = map(percentA, 0, 1, y0, y1);
    float dashXb = map(percentB, 0, 1, x0, x1); 
    float dashYb = map(percentB, 0, 1, y0, y1);

    line (dashXa, dashYa, dashXb, dashYb);
  }
  
  image(cursorImage, mouseX,mouseY, 90, 126); 
}

void keyPressed() {
  if (key == ' ') {
    save("../dashed_line.png");
  }
}
