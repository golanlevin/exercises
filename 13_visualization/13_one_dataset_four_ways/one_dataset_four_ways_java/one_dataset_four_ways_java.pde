Table incidentTable;
ArrayList<Datum> myData;
float minLat, maxLat; 
float minLon, maxLon;
int minDate, maxDate; 

PShape usa; 

int NB = -1;
int MALE = 0; 
int FEMALE = 1; 

ArrayList<Datum> massEvents;
float radiusScale = 8;
float MAX_VEL = 7; 
float DAMPING = 0.96;
float REPEL = 1.5;
float CENT = 0.01;

class Datum {
  PVector gps; 
  PVector p;
  PVector v; 
  float r;
  int date; 
  int gender;
  int age; 
  int count; 

  Datum (float lon, float lat, int d, int a, int g) {
    gps = new PVector(lon, lat); 
    date = d;
    age = a;
    gender = g;
    count = 1;

    p = new PVector(0, 0); 
    v = new PVector(0, 0);
    r = 0;
  }

  String toString() {
    return (date + "\t" + count);
  }

  void applyForce(float fx, float fy) {
    v.x += fx; 
    v.y += fy;
  }
  void update() {
    float vel = sqrt(v.x*v.x + v.y*v.y);
    if (vel > MAX_VEL) {
      v.x *= MAX_VEL/vel;
      v.y *= MAX_VEL/vel;
    }
    v.x *= DAMPING;
    v.y *= DAMPING;
    p.x += v.x;
    p.y += v.y;
  }
}

//----------------------------------------------
void setup() {
  size(800, 800, FX2D);
  smooth();
  usa = loadShape("usa_equirectangular_medgray_nostroke.svg");
  // noLoop(); 

  loadData(); 
  computeBounds();
  initEvents();
}

//----------------------------------------------
void draw() {
  background(253);

  plotMapPoints();
  plotTimeline();
  plotAges();
  plotMassEvents();
}




//----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("one_dataset_four_ways.png");
  }
}



void plotMassEvents() {

  // mutual repel
  for (int i=0; i<massEvents.size(); i++) {
    Datum E = massEvents.get(i);
    float ex = E.p.x;
    float ey = E.p.y;
    float er = E.r;
    for (int j=0; j<i; j++) {
      Datum F = massEvents.get(j);
      float fx = F.p.x;
      float fy = F.p.y;
      float fr = F.r;

      float dx = fx - ex;
      float dy = fy - ey;
      float dh = dist(ex, ey, fx, fy); 
      if ((dh > 0) && (dh < (er+fr))) {
        float tx = dx*REPEL;
        float ty = dy*REPEL;
        massEvents.get(i).applyForce(-tx/(er*er), -ty/(er*er));
        massEvents.get(j).applyForce( tx/(fr*fr), ty/(fr*fr));
      }
    }
  }

  for (int i=0; i<massEvents.size(); i++) {
    Datum E = massEvents.get(i);
    float ex = E.p.x;
    float ey = E.p.y;

    float dx = (width/2 - 20) - ex; 
    float dy = height/2 - ey;
    float dh = sqrt(dx*dx + dy*dy);
    if (dh > 0) {
      massEvents.get(i).applyForce(dx/dh* CENT, dy/dh* CENT);
    }
  }


  for (int i=0; i<massEvents.size(); i++) {
    massEvents.get(i).update();
  }



  
  pushMatrix();
  translate( width*0.75, height*0.75); 
  scale(0.5); 
  translate(-width/2, -height/2); 
  
  fill(56, 127); 
  noStroke(); 
  for (int i=0; i<massEvents.size(); i++) {
    Datum E = massEvents.get(i);
    float px = E.p.x;
    float py = E.p.y;
    float pr = E.r;
    ellipse(px, py, pr*2+9, pr*2+9);
  }
  
  fill(229); 
  stroke(0); 
  strokeWeight(3.5); 
  for (int i=0; i<massEvents.size(); i++) {
    Datum E = massEvents.get(i);
    float px = E.p.x;
    float py = E.p.y;
    float pr = E.r;
    ellipse(px, py, pr*2, pr*2);
  }
  popMatrix(); 
}


//----------------------------------------------
void initEvents() {

  ArrayList<Datum> events;
  events = new ArrayList<Datum>(); 

  for (int i=0; i<myData.size(); i++) {
    // look through every data
    Datum aDatum = myData.get(i); 
    PVector gps = aDatum.gps;
    int date = aDatum.date;

    boolean bMatchFound = false;
    for (int j=0; j<events.size(); j++) {
      Datum anEvent = events.get(j); 
      if (
        (aDatum.gps.x == anEvent.gps.x) &&
        (aDatum.gps.y == anEvent.gps.y) &&
        (aDatum.date == anEvent.date)) {
        bMatchFound = true;
        events.get(j).count++;
      }
    }
    if (bMatchFound == false) {
      Datum D = new Datum (gps.x, gps.y, date, 0, NB);
      events.add(D);
    }
  }

  massEvents = new ArrayList<Datum>(); 
  for (Datum E : events) {
    if (E.count >= 3) {
      massEvents.add(E);
    }
  }

  for (int i=0; i<massEvents.size(); i++) {
    float r = radiusScale * sqrt(massEvents.get(i).count);
    float rx = random(r, width-r); 
    float ry = random(r, height-r); 
    massEvents.get(i).p.set(rx, ry); 
    massEvents.get(i).v.set(0, 0);
    massEvents.get(i).r = r;
  }
}









//----------------------------------------------
void plotAges() {

  int binW = 5;
  int minAge = 1; 
  int maxAge = 110; 
  int nAgeBins = maxAge/binW; 
  int maxCount = 0; 
  int ageBinsM[] = new int[nAgeBins];
  int ageBinsF[] = new int[nAgeBins];
  for (int i=0; i<myData.size(); i++) {
    Datum aDatum = myData.get(i); 
    int age = aDatum.age; 
    if ((age < maxAge) && (age >= minAge)) {
      int bin = age/binW; 
      int gender = aDatum.gender;
      if (gender == MALE) {
        ageBinsM[bin]++;
      } else if (gender == FEMALE) {
        ageBinsF[bin]++;
      } 
      maxCount = max(maxCount, ageBinsM[bin]); 
      maxCount = max(maxCount, ageBinsF[bin]);
    }
  }

  float agePlotMarginL = 40;
  float agePlotMarginT = 20; 
  float agePlotMarginR = 20;
  float agePlotMarginB = 40;
  float agePlotL = agePlotMarginL; 
  float agePlotR = width/2 - agePlotMarginR; 
  float agePlotT = height/2 + agePlotMarginT; 
  float agePlotB = height - agePlotMarginB; 
  float agePlotMy = (agePlotT + agePlotB)/2;
  float rw = ceil((agePlotR - (agePlotL+1))/nAgeBins);

  stroke(0, 0, 0);  
  strokeWeight(4);
  strokeJoin(MITER); 
  for (int i=0; i<nAgeBins; i++) {
    float countF = (float) ageBinsF[i];
    float countM = (float) ageBinsM[i];
    float rx = map(i, 0, nAgeBins, agePlotL+1, agePlotR); 
    float rhF = map(countF, 0, maxCount, 0, (agePlotB-agePlotT)/2); 
    float rhM = map(countM, 0, maxCount, 0, (agePlotB-agePlotT)/2); 
    rect(rx, agePlotMy, rw, -rhM); 
    rect(rx, agePlotMy, rw, rhF);
  }

  for (int i=0; i<nAgeBins; i++) {
    float countF = (float) ageBinsF[i];
    float countM = (float) ageBinsM[i];
    float rx = map(i, 0, nAgeBins, agePlotL+1, agePlotR); 
    float rhF = map(countF, 0, maxCount, 0, (agePlotB-agePlotT)/2); 
    float rhM = map(countM, 0, maxCount, 0, (agePlotB-agePlotT)/2); 

    noStroke(); 
    fill(229); // fill(130, 160, 255); 
    rect(rx, agePlotMy, rw, -rhM); 
    fill(160); // fill(255, 180, 180); 
    rect(rx, agePlotMy, rw, rhF);
  }


  strokeWeight(8); 
  strokeCap(PROJECT);
  //line(datePlotL+1, datePlotB, datePlotR-3, datePlotB); 
  line(agePlotL, agePlotB, agePlotL, agePlotT);
}

//----------------------------------------------
void plotTimeline() {

  int nDaysInDataset = maxDate - minDate + 1;
  int countsPerDay[] = new int[nDaysInDataset];

  int maxCountPerDay = 0; 
  for (int i=0; i<myData.size(); i++) {
    Datum aDatum = myData.get(i); 
    int date = aDatum.date; 
    int dateIndex = date - minDate;
    int count = countsPerDay[dateIndex]++;
    if (count > maxCountPerDay) {
      maxCountPerDay = count;
    }
  }

  float datePlotMarginL = 20;
  float datePlotMarginT = 40; 
  float datePlotMarginR = 40;
  float datePlotMarginB = 20;
  float datePlotL = width/2 + datePlotMarginL; 
  float datePlotR = width - datePlotMarginR; 
  float datePlotT = datePlotMarginT; 
  float datePlotB = height/2 - datePlotMarginB; 
  stroke(0);
  fill(229); 
  strokeWeight(1.333); 
  strokeJoin(ROUND); 
  beginShape();
  vertex(datePlotL, datePlotB);
  for (int j=1; j<nDaysInDataset-1; j++) {
    float px = map(j, 0, nDaysInDataset-1, datePlotL, datePlotR); 
    float ci = countsPerDay[j-1]; 
    float cj = countsPerDay[j  ]; 
    float ck = countsPerDay[j+1]; 
    float countSmoothed = (ci+cj+ck)/3.0;
    float py = map(countSmoothed, 0, maxCountPerDay, datePlotB, datePlotT);
    vertex(px, py);
  }
  vertex(datePlotR, datePlotB); 
  endShape(CLOSE); 

  strokeWeight(8); 
  strokeCap(PROJECT);
  line(datePlotL+1, datePlotB, datePlotR-3, datePlotB); 
  line(datePlotL, datePlotB, datePlotL, datePlotT);
}



//----------------------------------------------
void plotMapPoints() {


  // Correct for latitude. 
  // The farther North you go, 
  // the smaller the y "pixels" get. 
  double dx = maxLon - minLon; 
  double dy = maxLat - minLat;
  double yMid = (minLat + maxLat)/2.0; 
  double cosineOfLat = cos(radians((float)yMid)); 

  // Compute the scale of the map
  double mapW = dx; 
  double mapH = dy; 
  double mapScale = Math.min(width/mapW, width/mapH); 
  mapScale *= 0.45;
  double mapScaleX = mapScale ;
  double mapScaleY = mapScale / cosineOfLat;

  mapW *= mapScaleX;
  mapH *= mapScaleY;
  float marginx =     (float)(width/2 - mapW)/2.0 + 10;
  float marginy =     (float)(height/2 - mapH)/2.0 + 20;

  // draw the gray USA
  pushMatrix(); 
  translate(marginx, marginy); 
  scale((float)mapScaleX, (float)mapScaleY); 
  translate((-180 - minLon), 0-(maxLat-8)); 
  shape(usa, 0, 0); 
  popMatrix(); 


  // Draw the correctly-scaled points
  pushMatrix();
  translate(marginx, marginy);
  strokeWeight(2.0); 
  stroke(0, 0, 0); 
  for (int i=0; i<myData.size(); i++) {
    Datum aDatum = myData.get(i); 
    PVector aPoint = aDatum.gps;          
    float px =   (float) dmap(aPoint.x, minLon, maxLon, 0, mapW); 
    float py =  ((float) dmap(aPoint.y, minLat, maxLat, mapH, 0)); 
    point(px, py);
  }
  popMatrix();
}


//----------------------------------------------
void loadData() {
  // Load the data into an array of points. 
  // Data adapted from:
  // https://data.cityofnewyork.us/Social-Services/Rat-Sightings/3q43-55fe
  // View based on 311 Service Requests from 2010 to Present

  incidentTable = loadTable("SlateGunDeaths.tsv", "header"); 
  myData = new ArrayList<Datum>(); 
  for (int i=0; i<incidentTable.getRowCount(); i++) {
    TableRow aRow = incidentTable.getRow(i); 

    // Location
    float lon = aRow.getFloat("lng"); // X
    float lat = aRow.getFloat("lat"); // Y

    // Demographics
    int age = aRow.getInt("age"); 
    int gender = NB;
    String genderStr = aRow.getString("gender");
    if (genderStr.equals("F")) {
      gender = FEMALE;
    } else if (genderStr.equals("M")) {
      gender = MALE;
    } 

    // Date
    String dateString = aRow.getString("date"); // e.g. "1/20/13"
    String[] dataParts = split(trim(dateString), "/"); 
    int M = Integer.parseInt(dataParts[0]) -1; 
    int D = Integer.parseInt(dataParts[1]) -1;
    int Y = Integer.parseInt(dataParts[2]); 
    int date = getDayOfYear(Y, M, D);
    if (Y == 12) {
      date -=366;
    }
    Datum  aDatum = new Datum(lon, lat, date, age, gender); 
    myData.add(aDatum);
  }
}


//--------------------------------------------------------
int getDayOfYear(int year, int month, int day) {
  int nFebs = 28;
  int nDays = 365;
  if ((year%400) == 0) {
    nDays = 366; 
    nFebs = 29;
  } else if (year%100 == 0) {
    ; // nope
  } else if (year%4 == 0) { 
    nDays = 366; 
    nFebs = 29;
  }

  int md[] = {31, nFebs, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  int dayTotal = 0; 
  for (int m=0; m<month; m++) {
    dayTotal += md[m];
  }
  dayTotal+=day; 

  // float frac = (float)dayTotal / (float)nDays; 
  // return frac;
  return dayTotal;
}


//----------------------------------------------
void computeBounds() {
  // Compute bounds on the points. 
  minLat = Float.MAX_VALUE; 
  minLon = Float.MAX_VALUE; 
  maxLat = 0-Float.MAX_VALUE; 
  maxLon = 0-Float.MAX_VALUE; 
  minDate = 99999;
  maxDate = -99999;

  for (Datum D : myData) { 
    int date = D.date; 
    if (date > maxDate) {
      maxDate = date;
    }
    if (date < minDate) {
      minDate = date;
    }

    PVector aVector = D.gps;
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



  // Per https://en.wikipedia.org/wiki/List_of_extreme_points_of_the_United_States, 
  // Clobber the calculations above to clip the map to the lower 48. 
  // Apologies to Alaska, Hawaii, Puerto Rico, and territories. 

  // Cape Alava, Washington (48°9′51″N 124°43′59″W) 
  // – westernmost point on the U.S. mainland (contiguous)
  minLon = -124.733;

  // Sumas, Washington 49°00′08.6″N 122°15′40″W
  // – northernmost incorporated place in the 48 contiguous states 
  // (because of 19th century survey inaccuracy placing the international 
  // border slightly north of the 49th parallel here.) 
  maxLat = 49.01;

  // Ballast Key, Florida (24°31′15″N 81°57′49″W) 
  // – southernmost point in the 48 contiguous states continuously above water
  minLat = 24.516;
}

//----------------------------------------------
double dmap (double val, double in0, double in1, double out0, double out1) {
  return out0 + (((val - in0)/(in1 - in0)) * (out1 - out0));
}
