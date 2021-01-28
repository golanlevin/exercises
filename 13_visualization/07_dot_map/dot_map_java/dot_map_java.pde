Table incidentTable;
ArrayList<PVector> gpsPoints;
float minLat, maxLat; 
float minLon, maxLon;

PFont myFont; 

//----------------------------------------------
void setup() {
  size(800, 800, FX2D);
  smooth();
  noLoop(); 
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60); 

  loadData(); 
  computeBounds();
}

//----------------------------------------------
void draw() {
  background(253);
  plotPoints(); 
  
  fill(0); 
  text ("NYC\nRats", 40, 96); 
}

//----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("dot_map.png");
  }
}


//----------------------------------------------
void plotPoints() {

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
  double mapScale = 2.5 * Math.min(width/mapW, width/mapH); 
  mapW *= mapScale;
  mapH *= mapScale;
  float marginx = (float) (width - mapW)/2.0;
  float marginy = (float) (height - mapH)/2.0;
  marginx -= 130; 
  marginy -= 130; // attractive offset

  // Draw the correctly-scaled points
  strokeWeight(1.75); 
  stroke(0,0,0, 127); 

  for (int i=0; i<gpsPoints.size(); i++) {
    PVector aPoint = gpsPoints.get(i);          
    float px = marginx + (float) dmap(aPoint.x, minLon, maxLon, 0, mapW); 
    float py = height - (marginy + (float) dmap(aPoint.y, minLat, maxLat, 0, mapH)); 
    point(px, py);
  }
}


//----------------------------------------------
void loadData() {
  // Load the data into an array of points. 
  // Data adapted from:
  // https://data.cityofnewyork.us/Social-Services/Rat-Sightings/3q43-55fe
  // View based on 311 Service Requests from 2010 to Present

  incidentTable = loadTable("rat_sightings_lite.tsv", "header"); 
  gpsPoints = new ArrayList<PVector>(); 
  for (int i=0; i<incidentTable.getRowCount(); i++) {
    TableRow aRow = incidentTable.getRow(i); 
    float lon = aRow.getFloat("Longitude"); // X
    float lat = aRow.getFloat("Latitude");  // Y
    gpsPoints.add(new PVector(lon, lat));
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
