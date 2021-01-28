float side;

void setup() {
  size(800, 800, FX2D);
  side = 200;
  // noLoop();
}

void draw() {
  background(253);

  float rot = 0;
  boolean flip = false;


  float y = 0;
  while (y < height) {
    rot = 0;
    flip = false;
    for (float x = width; x >= 0; x -= side) {
      drawSingle(x, y, rot, flip);
      rot += TWO_PI/3.0;
    }

    y += side/(2.0 * sqrt(3)) + 2;
    rot = PI/3;
    flip = true;
    for (float x = width + side/2; x >= 0; x -= side) {
      drawSingle(x, y, rot, flip);
      rot -= TWO_PI/3.0;
    }

    y += side/(sqrt(3));
    rot = 2.0*PI/3;
    flip = false;
    for (float x = width + side/2; x >= 0; x -= side) {
      drawSingle(x, y, rot, flip);
      rot += TWO_PI/3.0;
    }

    y += side/(2.0 * sqrt(3)) + 2;
    rot = PI;
    flip = true;
    for (float x = width; x >= 0; x -= side) {
      drawSingle(x, y, rot, flip);
      rot -= TWO_PI/3.0;
    }

    y += side/sqrt(3);
  }
}

void drawSingle(float x, float y, float rot, boolean flip) {
  float sq3 = sqrt(3);
  float s2 = side/2;
  float eyeDx = 9; 
  float eyeLh = -1.5; 
  float mouthDa = 0.35;
  float mouthDy = 11; 
  float s3 = side * 0.30;
  float faceDy = -3;

  pushMatrix();
  translate(x, y + 42);
  rotate(rot);
  if (flip) {
    scale(-1, 1);
  } 


  noFill();
  stroke(0);
  strokeWeight(2);
  triangle( 
    -s2, 
    -side/(2.0 * sq3), 
    s2, 
    -side/(2.0 * sq3), 
    0, 
    side/sq3);

  strokeWeight(8);
  translate(0, faceDy); 
  arc(
    side/2-side/2, 
    side/4-side/(2.0 * sq3) + mouthDy, 
    s3, s3, 
    PI+mouthDa, TWO_PI-mouthDa);
  ellipse(
    side*2/5-s2 + eyeDx, 
    side/2.5-side/(2.0 * sq3), 
    side/8, 
    side/5);
  line( 
    side*5/8-s2 - eyeDx, 
    side/2.5-side/10-side/(2.0 * sqrt(3)) - eyeLh, 
    side*5/8-s2 - eyeDx, 
    side/2.5+side/10-side/(2.0 * sqrt(3)) + eyeLh);

  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("kaleidoscope.png");
  }
}
