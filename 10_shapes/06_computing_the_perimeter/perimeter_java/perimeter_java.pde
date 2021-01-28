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
  stroke(0); 
  strokeJoin(MITER); 
  strokeWeight(8.0/mag);

  float perimeter = 0; 
  beginShape();
  for (int i=0; i<nPoints; i++) {
    float px = xData[i];
    float py = yData[i];
    float qx = xData[(i+1)%nPoints];
    float qy = yData[(i+1)%nPoints];
    float delta = dist(px, py, qx, qy); 
    perimeter += delta;
    vertex(px, py);
  }
  endShape(CLOSE);
  popMatrix(); 


  fill(0); 
  textAlign(CENTER); 
  text("Perimeter = " + ((int)round(perimeter)) + " pixels", width/2, 730);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("perimeter.png");
  }
}
