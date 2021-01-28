
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

void setup() {
  size(800, 800);
}



float mag = 5.0;
void draw() {
  background(253); 
  pushMatrix();
  scale (mag); 
  translate(23, 9);

  renderPointsOfHighCurvature(xData, yData);
  renderData(xData, yData);


  popMatrix();
}

//==========================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("high_curvature.png");
  }
}


//==========================================
void renderData(int[] xpts, int[] ypts) {
  int nPoints = xpts.length;
  fill(229); 
  stroke(0); 
  strokeJoin(MITER); 
  strokeWeight(8.0/mag);
  beginShape();
  for (int i=0; i<nPoints; i++) {
    vertex(xpts[i], ypts[i]);
  }
  endShape(CLOSE);
}

//==========================================
void renderPointsOfHighCurvature(int[] xpts, int[] ypts) {

  int nPoints = xpts.length;

  for (int j=0; j<nPoints; j++) {
    float xi = xpts[(j-1+nPoints)%nPoints];
    float yi = ypts[(j-1+nPoints)%nPoints];

    float xj = xpts[j];
    float yj = ypts[j];

    float xk = xpts[(j+1)%nPoints];
    float yk = ypts[(j+1)%nPoints];

    float dxij = xi-xj;
    float dyij = yi-yj;
    float dhij = sqrt(dxij*dxij + dyij*dyij);

    float dxkj = xk-xj;
    float dykj = yk-yj;
    float dhkj = sqrt(dxkj*dxkj + dykj*dykj);

    float dot = dxij*dxkj + dyij*dykj;
    float cross = dxij*dykj - dyij*dxkj;
    float theta = acos(dot/(dhij*dhkj));
    if (Float.isNaN(theta) == false) {

      float deg = degrees(abs(theta));
      if (deg < mouseX) {


        float r = map(abs(theta), 0, PI, 30, 0); 
        if (cross < 0) {
          noStroke(); 
          fill(255, 0, 0, 150); 
          ellipse(xj, yj, r, r);
        }
      }
    }
  }

  println(mouseX);
}
