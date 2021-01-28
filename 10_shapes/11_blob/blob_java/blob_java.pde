// Tracing the contours of metaballs (implicit curves) using Marching Square
// 
// Reference:
// Metaballs (by Daniel Shiffman): https://thecodingtrain.com/CodingChallenges/028-metaballs.html
// Marching Squares (also by the wonderful Daniel Shiffman): https://thecodingtrain.com/challenges/coding-in-the-cabana/005-marching-squares.html

Blob[] blobs = new Blob[6];

float[][] field;
int rez = 1;
int cols, rows;
float increment = 0.1;
float zoff = 0;

void setup() {
  size(800, 800);
  colorMode(HSB);
  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new Blob();
  }
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  field = new float[cols][rows];
}

void line(PVector v1, PVector v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}

void draw() {
  background(253);
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      float sum = 0;
      for (Blob b : blobs) {
        float d = dist(x*rez, y*rez, b.pos.x, b.pos.y);
        sum += 20 * b.r / d;
      }
      if (sum > 105) {
        field[x][y] = 1;
      } else {
        field[x][y] = 0;
      }
    }
  }
  
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows-1; j++) {
      float x = i * rez;
      float y = j * rez;
      PVector a = new PVector(x + rez * 0.5, y);
      PVector b = new PVector(x + rez, y + rez * 0.5);
      PVector c = new PVector(x + rez * 0.5, y + rez);
      PVector d = new PVector(x, y + rez * 0.5);
      int state = getState(ceil(field[i][j]), ceil(field[i+1][j]), 
        ceil(field[i+1][j+1]), ceil(field[i][j+1]));
      drawSquare(state, a, b, c, d);
    }
  }
  
  for (Blob b : blobs) {
    b.update();
    // b.show();
  }
}

void drawSquare(int state, PVector a, PVector b, PVector c, PVector d) {
  strokeWeight(8);
  stroke(0);
  switch (state) {
    case 1:  
      line(c, d);
      break;
    case 2:  
      line(b, c);
      break;
    case 3:  
      line(b, d);
      break;
    case 4:  
      line(a, b);
      break;
    case 5:  
      line(a, d);
      line(b, c);
      break;
    case 6:  
      line(a, c);
      break;
    case 7:  
      line(a, d);
      break;
    case 8:  
      line(a, d);
      break;
    case 9:  
      line(a, c);
      break;
    case 10: 
      line(a, b);
      line(c, d);
      break;
    case 11: 
      line(a, b);
      break;
    case 12: 
      line(b, d);
      break;
    case 13: 
      line(b, c);
      break;
    case 14: 
      line(c, d);
      break;
  }
}

int getState(int a, int b, int c, int d) {
  return a * 8 + b * 4  + c * 2 + d * 1;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("blob_#####.png");
  }
}
