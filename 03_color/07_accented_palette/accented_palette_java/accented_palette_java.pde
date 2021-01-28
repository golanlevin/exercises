void setup() {
  size(800, 800); 
  
  // Complementary is a color scheme using one base color and its complement, 
  // the color on the exact opposite side of the color wheel. 
  // The base color is main and dominant, while the complementary color is used only as an accent. 
  // http://paletton.com/wiki/index.php?title=Complementary_color_scheme
  
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  
  background(0, 0, 100);
  
  float hA = map(mouseX, 0, width, 0, 360);
  float sA = 100;
  float bA = 90; 
  color c1 = color(hA, sA, bA);

  float hB = (hA + 180.0)%360.0;
  float sB = sA; 
  float bB = bA; 
  color c2 = color(hB, sB, bB);

  noStroke();

  fill(c1);
  rect(0, 0, width*0.75, 120);
  fill(c2);
  rect(width*0.75, 0, width*0.25, 120);
  
  for (float xx = 0; xx < width*0.75; xx += width*0.15) {
    float b = map(xx, 0, width*0.75, 100, 0);
    fill(hA, sA, b);
    rect(xx, 120, width*0.15, 40); 
  }
  
  for (float xx = width*0.75; xx < width; xx += width*0.05) {
    float b = map(xx, width*0.75, width, 100, 0);
    fill(hB, sB, b);
    rect(xx, 120, width*0.05, 40); 
  }

  int nx = 20; 
  int ny = 16; 
  float rw = width/nx; 
  float rh = height/ny;
  for (int y=0; y<ny; y++) {
    for (int x=0; x<nx; x++) {
      float rx = map(x, 0, nx, 0, width); 
      float ry = map(y, 0, ny, 4*rh, height); 
      float pick = random(100);
      float s = random(50, 100);
      float b = random(50, 100);
      if (pick < 75) {
        fill(hA, s, b);
      } else {
        fill(hB, s, b);
      }
      rect(rx, ry, rw, rh);
    }
  }

  noLoop();
}

void mouseMoved() {
  loop();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("color_and_randomness.png");
  }
}
