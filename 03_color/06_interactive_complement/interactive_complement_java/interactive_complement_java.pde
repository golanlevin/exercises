
PImage cursorImg; 

//------------------------------------
void setup() {
  size(800, 800);
  noStroke();
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
}

//------------------------------------
void draw() {
  // A complementary color scheme is a two-color combination consisting of a base color (H0) and another color (H1) that is 180 degrees apart from H0 on the color wheel.
  // https://www.ethangardner.com/articles/2009/03/15/a-math-based-approach-to-color-theory-using-hue-saturation-and-brightness-hsb/
  colorMode(HSB, 360, 100, 100);

  float hA = map(mouseX, 0, width, 0, 360);
  float sA = map(mouseY, 0, height, 0, 100);
  float bA = 100; 
  fill(hA, sA, bA);
  rect(0, 0, width, height);

  float hB = (hA + 180.0)%360.0;
  float sB = sA; 
  float bB = bA; 
  fill(hB, sB, bB);
  rect(width/2, 0, width/2, height);

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("color_complement.png");
  }
}
