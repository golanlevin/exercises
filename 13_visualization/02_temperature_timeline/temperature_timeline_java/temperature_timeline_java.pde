Table temperatureTable; 
// Data from:
// https://datahub.io/core/global-temp#resource-global-temp_zip

PFont myFont; 
ArrayList<PVector> temperatureData; 
float minTemp;
float maxTemp;
float minTime;
float maxTime; 
boolean bDoSave = false;

void setup() {
  size(800, 800, FX2D);
  // noLoop(); 

  myFont = loadFont("Helvetica-Bold-56.vlw");
  textFont(myFont, 56); 

  loadAndStoreData(); 
  computeBounds();
}

void keyPressed() {
  if (key == ' ') {
    bDoSave = true;
  }
}


//--------------------------------------------------------
void draw() {
  background(253);

  noFill(); 
  stroke(0); 
  strokeWeight(2); 
  
  float marginX = width/10; 
  float marginY = width/10; 
  float L = marginX; 
  float R = width - marginX;
  float T = marginY;   
  float B = height - 2*marginY; 

  fill(240);
  stroke(0); 
  strokeWeight(2.0); 
  strokeJoin(ROUND);
  
  
  beginShape();
  vertex(R,B); 
  int nData = temperatureData.size(); 
  for (int i=1; i<nData-1; i++) {
    PVector aVector = temperatureData.get(i-1);
    PVector bVector = temperatureData.get(i  );
    PVector cVector = temperatureData.get(i+1);
    
    float tempRawA = aVector.y;
    float tempRawB = bVector.y;
    float tempRawC = cVector.y;
    float tempRaw = (tempRawA + tempRawB + tempRawC)/3.0;
    float timeRaw = aVector.x;
    
    float timex = map(timeRaw, minTime, maxTime, L, R);
    float tempy = map(tempRaw, minTemp, maxTemp, B-marginY, T); 
    vertex(timex, tempy); 
  }
  vertex(L,B); 
  endShape(CLOSE); 
  
  
  strokeWeight(8);
  strokeCap(PROJECT);
  line(L, B, R-3, B); 
  line(L, B, L, T);

  
  int minYear = (int)minTime;
  int maxYear = (int)maxTime;
  
  fill(0); 
  noStroke();
  textAlign(CENTER, BASELINE); 
  text("Global Temp.," + minYear + "–" + maxYear, width/2, height-marginY); 

  if (bDoSave) {
    saveFrame("temperature_timeline.png"); 
    bDoSave = false;
  }
}



//--------------------------------------------------------
void computeBounds() {
  minTemp =  Float.MAX_VALUE; 
  maxTemp = -Float.MAX_VALUE;
  minTime =  Float.MAX_VALUE;
  maxTime = -Float.MAX_VALUE;

  for (PVector aDatum : temperatureData) {
    float temp = aDatum.y;
    if (temp > maxTemp) {
      maxTemp = temp;
    }
    if (temp < minTemp) {
      minTemp = temp;
    }

    float time = aDatum.x; 
    if (time > maxTime) {
      maxTime = time;
    }
    if (time < minTime) {
      minTime = time;
    }
  }
}

//--------------------------------------------------------
void loadAndStoreData() {

  /* Sample header & data:
   * Source,Date,Mean
   * GCAG,2016-12-06,0.7895
   * GISTEMP,2016-12-06,0.81
   */

  // Load and store data
  temperatureTable = loadTable("global-temp/monthly_csv.csv", "header"); 
  temperatureData = new ArrayList<PVector>(); 

  for (int i=0; i<temperatureTable.getRowCount(); i++) {
    TableRow aRow = temperatureTable.getRow(i); 
    String source = aRow.getString("Source"); 
    if (source.equals("GCAG")) {

      float temp = aRow.getFloat("Mean");
      if (!Float.isNaN(temp)) {
        String dateString = aRow.getString("Date");
        String[] dataParts = split(trim(dateString), "-"); 
        int Y = Integer.parseInt(dataParts[0]); 
        int M = Integer.parseInt(dataParts[1]) -1; 
        int D = Integer.parseInt(dataParts[2]) -1;
        float frac = getDateFractionOfYear(Y, M, D);
        float time = Y + frac;

        temperatureData.add(new PVector(time, temp));
      }
    }
  }
}




//--------------------------------------------------------
float getDateFractionOfYear(int year, int month, int day) {
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

  float frac = (float)dayTotal / (float)nDays; 
  return frac;
}
