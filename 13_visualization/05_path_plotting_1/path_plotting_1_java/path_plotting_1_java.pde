Table gpsPathTable;
ArrayList<PVector> gpsPoints;
float minLat, maxLat; 
float minLon, maxLon;

//----------------------------------------------
void setup() {
  size(800, 800);
  noLoop(); 

  loadData(); 
  computeBounds();
}

//----------------------------------------------
void draw() {
  background(253);
  plotPath();
}

//----------------------------------------------
void keyPressed(){
  if (key == ' '){
    saveFrame("path_plotting.png"); 
  }
}


//----------------------------------------------
void plotPath() {

  // Correct for latitude. 
  // The farther North you go, 
  // the smaller the y "pixels" get. 
  double dx = maxLon - minLon; 
  double dy = maxLat - minLat;
  double yMid = (minLat + maxLat)/2.0; 
  double cosineOfLat = cos(radians((float)yMid)); 

  // Compute the scale of the map
  double mapW = dx * cosineOfLat; 
  double mapH = dy; 
  double mapScale = 0.88 * Math.min(width/mapW, width/mapH); 
  mapW *= mapScale;
  mapH *= mapScale;
  float marginx = (float) (width - mapW)/2.0;
  float marginy = (float) (height - mapH)/2.0;

  // Draw the correctly-scaled path
  noFill();
  stroke(0, 0, 0); 
  strokeWeight(8);
  beginShape();
  for (int i=0; i<gpsPoints.size(); i++) {
    PVector aPoint = gpsPoints.get(i);          
    float px = marginx + (float) dmap(aPoint.x, minLon, maxLon, 0, mapW); 
    float py = marginy + (float) dmap(aPoint.y, minLat, maxLat, 0, mapH); 
    vertex(px, py);
  }
  endShape();
}


//----------------------------------------------
void loadData() {
  // Load the data into an array of points
  // Path data from https://github.com/cwarwicker/Waddle/blob/master/tests/run.csv
  gpsPathTable = loadTable("run.csv", "header"); 
  gpsPoints = new ArrayList<PVector>(); 
  for (int i=0; i<gpsPathTable.getRowCount(); i++) {
    TableRow aRow = gpsPathTable.getRow(i); 
    if (aRow.getInt("activityType") == 0) {
      float lon = aRow.getFloat("long"); // X
      float lat = aRow.getFloat("lat");  // Y
      gpsPoints.add(new PVector(lon, lat));
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
}

//----------------------------------------------
double dmap (double val, double in0, double in1, double out0, double out1) {
  return out0 + (((val - in0)/(in1 - in0)) * (out1 - out0));
}
