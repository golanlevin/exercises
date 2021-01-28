int[] xData = {
  81, 83, 83, 83, 83, 82, 79, 77, 80, 83, 
  84, 85, 84, 90, 94, 94, 89, 85, 83, 75, 
  71, 63, 59, 60, 44, 37, 33, 21, 15, 12, 
  14, 19, 22, 27, 32, 35, 40, 41, 38, 37, 
  36, 36, 37, 43, 50, 59, 67, 71};
int[] yData = {
  10, 17, 22, 27, 33, 41, 49, 53, 67, 76, 
  93, 103, 110, 112, 114, 118, 119, 118, 121, 121, 
  118, 119, 119, 122, 122, 118, 113, 108, 100, 92, 
  88, 90, 95, 99, 101, 80, 62, 56, 43, 32, 
  24, 19, 13, 16, 23, 22, 24, 20};

/*
int[] xData = {
 7, 11, 18, 20, 25, 28, 32, 34, 37, 39, 42, 45, 50, 49, 
 47, 46, 45, 48, 51, 55, 61, 65, 61, 59, 55, 54, 57, 61, 
 66, 71, 71, 67, 63, 60, 64, 68, 73, 77, 75, 71, 66, 
 62, 53, 48, 45, 20, 21, 18, 16, 13, 10 };
 int[] yData = {
 32, 31, 36, 43, 48, 47, 41, 36, 27, 18, 12, 7, 6, 14, 
 22, 28, 35, 29, 22, 12, 5, 7, 19, 27, 34, 38, 33, 24, 
 15, 14, 20, 30, 40, 45, 41, 35, 28, 28, 36, 43, 51, 59, 
 75, 83, 89, 85, 73, 68, 61, 51, 42};
 */

float mag = 5; 

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(253); 

  pushMatrix();
  scale(mag); 
  translate(23, 9);

  int L = MAX_INT;
  int R = MIN_INT; 
  int T = MAX_INT;
  int B = MIN_INT; 
  int nPoints = xData.length;
  for (int i=0; i<nPoints; i++) {
    if (xData[i] < L) {
      L = xData[i];
    }
    if (xData[i] > R) {
      R = xData[i];
    }
    if (yData[i] < T) {
      T = yData[i];
    }
    if (yData[i] > B) {
      B = yData[i];
    }
  }
  noFill(); 
  strokeJoin(MITER);
  strokeWeight(8/mag); 
  stroke(255, 50, 50); 
  rect(L, T, R-L, B-T);

  renderData(xData, yData);

  popMatrix();
}

//==========================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("bounding_box.png");
  }
}


//==========================================
void renderData(int[] xpts, int[] ypts) {
  int nPoints = xpts.length;
  fill(229); 
  stroke(0); 
  strokeJoin(MITER);
  strokeWeight(8/mag); 
  beginShape();
  for (int i=0; i<nPoints; i++) {
    vertex(xpts[i], ypts[i]);
  }
  endShape(CLOSE);
}
