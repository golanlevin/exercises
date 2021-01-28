float offset;
int n;
float w;
int[] patternH;
int[] patternV;

PFont myFont;

void setup() {
  size(800, 800);
  myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 40);

  n = 12;
  offset = 80;
  w = (width-1.8*offset)/n;

  patternH = new int[n+1];
  patternV = new int[n+1];

  reset();
}

void draw() {
  background(253);
  
  pushMatrix(); 
  translate(10,10); 

  fill(0);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < n+1; i++) {
    text(str(patternH[i]), offset/2-5, offset+i*w);
  }
  for (int i = 0; i < n+1; i++) {
    text(str(patternV[i]), offset+i*w, offset/2-5);
  }


  stroke(0);
  strokeWeight(8);
  strokeCap(PROJECT); 
  for (int i = 0; i < n+1; i++) { 
    if (patternV[i] == 1) {
      for (int j = 0; j < n; j += 2) {
        line(offset+i*w, offset+j*w, offset+i*w, offset+(j+1)*w);
      }
    } else {
      for (int j = 1; j < n; j += 2) {
        line(offset+i*w, offset+j*w, offset+i*w, offset+(j+1)*w);
      }
    }
  } 

  for (int j = 0; j < n+1; j++) { 
    if (patternH[j] == 1) {
      for (int i = 0; i < n; i += 2) {
        line(offset+i*w, offset+j*w, offset+(i+1)*w, offset+j*w);
      }
    } else {
      for (int i = 1; i < n; i += 2) {
        line(offset+i*w, offset+j*w, offset+(i+1)*w, offset+j*w);
      }
    }
  } 


  popMatrix();
}

void reset() {
  for (int i = 0; i < n+1; i++) {
    int r1 = round(random(1));
    int r2 = round(random(1));
    patternH[i] = r1;
    patternV[i] = r2;
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("hitomezashi_sashiko.png");
  } else if (key == 'r') {
    reset();
  }
}
