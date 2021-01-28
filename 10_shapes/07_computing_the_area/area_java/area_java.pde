

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


PFont myFont; 

void setup() {
  size(800, 800);
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont);
  noLoop();
}

float mag = 5.0;
void draw() {
  background(253); 
  int nPoints = xData.length;

  pushMatrix(); 
  scale(mag); 
  translate(23, 1); 
  fill(229); 
  stroke(0); 
  strokeJoin(MITER); 
  strokeWeight(8.0/mag);
  beginShape();
  for (int i=0; i<nPoints; i++) {
    float px = xData[i];
    float py = yData[i];
    vertex(px, py);
  }
  endShape(CLOSE);
  popMatrix(); 

  // Gauss's Area Formula, Green's Theorem or "shoelace formula"
  // https://math.blogoverflow.com/2014/06/04/greens-theorem-and-area-of-polygons/
  // https://www.geeksforgeeks.org/area-of-a-polygon-with-given-n-ordered-vertices/
  float area = 0;
  int j = nPoints - 1; 
  for (int k = 0; k < nPoints; k++) { 
    area += ((xData[k] + xData[j]) * (yData[k] - yData[j]))/2.0; 
    j = k;  // swap; j is always the vertex previous to k
  } 

  fill(0);
  textAlign(CENTER); 
  text("Area = " + (int)area + " pixels", width/2, 730);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("area.png");
  }
}



/*
int[] xData = {
 14, 22, 36, 41, 50, 56, 65, 69, 74, 79, 84, 90, 100, 99, 
 95, 92, 91, 97, 102, 111, 122, 130, 122, 118, 111, 109, 114, 
 122, 132, 142, 142, 134, 126, 121, 128, 136, 147, 154, 151, 
 142, 132, 124, 106, 97, 90, 40, 42, 37, 33, 27, 21 };
 int[] yData = {
 64, 62, 73, 87, 97, 95, 83, 72, 55, 37, 24, 14, 13, 28, 
 45, 57, 71, 59, 44, 25, 10, 15, 38, 55, 69, 77, 67, 49, 
 30, 28, 41, 61, 80, 91, 82, 70, 56, 56, 72, 87, 102, 119, 
 151, 167, 179, 170, 147, 137, 122, 102, 85 };
 */
