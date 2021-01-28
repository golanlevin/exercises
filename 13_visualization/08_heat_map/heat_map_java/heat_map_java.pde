Table incidentTable;
ArrayList<PVector> gpsPoints;
float minLat, maxLat; 
float minLon, maxLon;

color palette[];

PGraphics pg;
PFont myFont; 

//----------------------------------------------
void setup() {
  size(800, 800, FX2D);
  pg = createGraphics(width, height); 
  pg.smooth();
  noLoop(); 

  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);

  loadData(); 
  computeBounds();
}

//----------------------------------------------
void draw() {
  background(0);




  pg.beginDraw();
  pg.background(0); 
  plotPoints(); 
  for (int i=0; i<4; i++) {
    pg.filter(BLUR, 5);
  }
  pg.loadPixels(); 
  pg.endDraw(); 

  float maxBri = 0; 
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int index = y*width + x; 
      color c = pg.pixels[index]; 
      float bri = c & 0x000000FF; 
      if (bri > maxBri) { 
        maxBri = bri;
      }
    }
  }

  float mx = (float)mouseX/(float)width;
  int nColors = 1+(int)ceil(maxBri);
  palette = new color[nColors];
  for (int i=0; i<nColors; i++) {
    float t = map(i, 0, nColors-1, 0.0, 1.0); 
    t = pow(t, 0.75); 
    float r = 255.0 * (0.5 - 0.5*cos(t * PI));
    float g = t * 255.0 * (0.5 + 0.5*cos(t * PI + 2.0));
    float b = 255.0 * (0.5 - 0.5*cos(t * 1.5*PI + 0.5));
    palette[i] = color(r, g, b);
  }

  loadPixels(); 
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int index = y*width + x; 
      color srcCol = pg.pixels[index]; 
      int bri = (srcCol & 0x000000FF); 
      color dstcol = palette[bri];
      pixels[index] = dstcol;
    }
  }
  updatePixels();

  fill(255); 
  ellipse(40,40, 1, 1);
  text ("NYC\nRats", 40, 96);
 
}

//----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("heat_map.png");
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
  pg.strokeWeight(2.0); 
  pg.stroke(255, 255, 255, 180); 

  for (int i=0; i<gpsPoints.size(); i++) {
    PVector aPoint = gpsPoints.get(i);          
    float px = marginx + (float) dmap(aPoint.x, minLon, maxLon, 0, mapW); 
    float py = height - (marginy + (float) dmap(aPoint.y, minLat, maxLat, 0, mapH)); 
    pg.point(px, py);
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
