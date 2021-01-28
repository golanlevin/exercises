Table gpsPathTable;
ArrayList<PVector> gpsPoints;
ArrayList<PVector> runData;
float minLat, maxLat; 
float minLon, maxLon;
float maxDistance; 
float maxSpeed; 

PFont myFont; 

//----------------------------------------------
void setup() {
  size(800, 800);
  noLoop(); 

  myFont = loadFont("Helvetica-Bold-72.vlw"); 
  textFont(myFont, 72); 

  loadData(); 
  computeBounds();
}

//----------------------------------------------
void draw() {
  background(253);

  float marginA = 160;
  float marginB = 80; 
  float L = marginA;
  float R = width-marginB; 
  float T = marginB;
  float B = height-marginA;

  // gray chart shape
  fill(240);
  noStroke(); 
  beginShape();
  vertex(L, B);
  for (int i=0; i<runData.size(); i++) {
    float speed = runData.get(i).y;
    float xD = map(i, 0, runData.size(), L, R); 
    float yS = map(speed, 0, maxSpeed, B, T); 
    vertex(xD, yS);
  }
  vertex(R, B);
  endShape(CLOSE); 

  // outline (stroke) of gray chart shape
  noFill(); 
  stroke(0); 
  strokeWeight(2); 
  strokeJoin(MITER);
  strokeCap(PROJECT);
  beginShape();
  for (int i=0; i<runData.size(); i++) {
    float speed = runData.get(i).y;
    float xD = map(i, 0, runData.size(), L, R); 
    float yS = map(speed, 0, maxSpeed, B, T); 
    vertex(xD, yS);
  }
  vertex(R, B);
  endShape(); 

  // Draw axes
  noFill();
  stroke(0); 
  strokeWeight(8);
  strokeCap(PROJECT);
  line(L, B, R-3, B); 
  line(L, B, L, T+4);


  fill(0); 
  textAlign(RIGHT, BASELINE);
  text("Time", R+2, B+80);
  pushMatrix(); 
  translate(L-4, T-2); 
  rotate(radians(-90)); 
  text("Speed", 0, -32);
  popMatrix();
}

//----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("path_plotting_2.png");
  }
}






//----------------------------------------------
void loadData() {
  // Load the data into an array of points
  // Path data from https://github.com/cwarwicker/Waddle/blob/master/tests/run.csv
  gpsPathTable = loadTable("run.csv", "header"); 
  gpsPoints = new ArrayList<PVector>(); 
  runData = new ArrayList<PVector>(); 

  for (int i=0; i<gpsPathTable.getRowCount(); i++) {
    TableRow aRow = gpsPathTable.getRow(i); 
    if (aRow.getInt("activityType") == 0) {
      float lon = aRow.getFloat("long"); // X
      float lat = aRow.getFloat("lat");  // Y
      gpsPoints.add(new PVector(lon, lat));

      float distance = aRow.getFloat("distance"); // X
      float speed = aRow.getFloat("speed"); // Y
      runData.add(new PVector(distance, speed));
    }
  }
}

//----------------------------------------------
void computeBounds() {
  // Compute bounds on the points. 
  minLat = Float.MAX_VALUE; 
  minLon = Float.MAX_VALUE; 
  maxLat = 0-Float.MAX_VALUE; 
  maxLon = 0-Float.MAX_VALUE; 

  for (PVector aVector : gpsPoints) { 
    if (aVector.x > maxLon) {
      maxLon = aVector.x;
    }
    if (aVector.x < minLon) {
      minLon = aVector.x;
    }
    if (aVector.y > maxLat) {
      maxLat = aVector.y;
    }
    if (aVector.y < minLat) {
      minLat = aVector.y;
    }
  }

  maxDistance = 0; 
  maxSpeed = 0; 
  for (PVector aVector : runData) { 
    if (aVector.x > maxDistance) {
      maxDistance = aVector.x;
    }
    if (aVector.y > maxSpeed) {
      maxSpeed = aVector.y;
    }
  }
}

//----------------------------------------------
double dmap (double val, double in0, double in1, double out0, double out1) {
  return out0 + (((val - in0)/(in1 - in0)) * (out1 - out0));
}
