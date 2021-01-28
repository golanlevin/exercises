int nPoints = 360;
int EPITROCHOID = 0; // Cartesian Parametric Form  [x=f(t), y=g(t)]
int CRANIOID = 1; // Polar explicit form   [r =f(t)]
PFont myFont;
String[] titles = {"Epitrochoid", "Cranioid"};
int curveMode = 0;

PImage cursorImg; 

//--------------------------------------------------
void setup() {
  size(800, 800, FX2D);
  smooth();
  myFont = loadFont("CenturySchoolbook-72.vlw");
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  textFont(myFont, 72);
}

//--------------------------------------------------
void draw() {
  background(253);

  // draw the frame
  fill(0); 
  noStroke();
  text(titles[curveMode], 50, 100);

  // draw the curve
  pushMatrix();
  translate(width / 2, height / 2 + 50);
  switch (curveMode) {
    case 0:
      drawEpitrochoidCurve();
      break;
    case 1:
      drawCranioidCurve();
      break;
  }
  popMatrix();

  image(cursorImg, mouseX, mouseY, 15*6,21*6); 
}

//--------------------------------------------------
void drawEpitrochoidCurve() {
  // Epicycloid:
  // http://mathworld.wolfram.com/Epicycloid.html

  float x;
  float y;
  float mx = mouseX; // 510; 
  float my = mouseY; // 546; 
  
  float a = 150;
  float b = a / 2.0;
  float h = constrain(my / 8.0, 0, b);
  float ph = mx / 50.0;

  fill(255, 200, 200);
  stroke(0);
  strokeWeight(8);
  strokeJoin(ROUND); 
  beginShape();
  for (int i = 0; i < nPoints; i++) {
    float t = map(i, 0, nPoints, 0, TWO_PI);

    x = (a + b) * cos(t) - h * cos(ph + t * (a + b) / b);
    y = (a + b) * sin(t) - h * sin(ph + t * (a + b) / b);
    vertex(x, y);
  }
  endShape(CLOSE);

}

//--------------------------------------------------
void drawCranioidCurve() {
  // http://mathworld.wolfram.com/Cranioid.html

  // NOTE: given a curve in the polar form  r = f(theta),
  // 1. sweep theta from 0...TWO_PI,
  // 2. then compute r as a function of theta,
  // 3. then compute x and y using the circular identity:
  //    x = r * cos(theta);
  //    y = r * sin(theta);

  float x;
  float y;
  float r;
  float a = 30.0;
  float b = 8.0;
  float c = 75.0;

  float p = constrain((mouseX / (float)width), 0.0, 1.0);
  float q = constrain((mouseY / (float)height), 0.0, 1.0);

  fill(200, 200, 255);
  stroke(0);
  strokeWeight(8);
  strokeJoin(ROUND); 
  
  beginShape();
  for (int i = 0; i < nPoints; i++) {
    float t = map(i, 0, nPoints, 0, TWO_PI);

    // cranioid:
    r =
      a * sin(t) +
      b * sqrt(1.0 - p * sq(cos(t))) +
      c * sqrt(1.0 - q * sq(cos(t)));

    x = r * cos(t);
    y = r * sin(t);
    vertex(x, y);
  }
  endShape(CLOSE);
}

//--------------------------------------------------
void mousePressed() {
  curveMode = 1 - curveMode;
}

void keyPressed() {
  saveFrame("polar_curve.png");
}
