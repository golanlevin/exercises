float n;
float w;
float offset;

void setup() {
  size(800, 800, FX2D);
  smooth();

  n = 10;
  offset = 50;
  w = (width-2*offset)/n;

  doDraw(); 
}

void draw() {
}


void doDraw() {
  background(253);

  strokeWeight(8);
  strokeCap(ROUND); 
  stroke(0); 

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int flip = round(random(1));
      drawLine(offset + i*w, offset + j*w, flip);
    }
  }
}

void drawLine(float x, float y, int flip) {
  float d = 4.0; 
  if (flip == 0) {
    line(x+d, y+d, x+w-d, y+w-d);
  } else {
    line(x+w-d, y+d, x+d, y+w-d);
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("ten_print_#####.png");
  } else {

    doDraw();
  }
}
