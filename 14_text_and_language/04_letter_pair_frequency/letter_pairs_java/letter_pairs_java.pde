String document[]; 
int letterPairCounts[][];
float maxval = 0;
float totalCounts = 0; 

PFont myHeadingFont;
PFont myNumberFont;


//=======================================================
void setup() {
  size(800, 800);
  noLoop(); 
  
  myHeadingFont = createFont("BellCentennialStd-NameNum", 48); 
  myNumberFont = createFont("BellCentennialStd-SubCapt", 24); 

  // Initialize letterPairCounts
  letterPairCounts = new int[26][26]; 
  for (int i=0; i<26; i++) {
    for (int j=0; j<26; j++) {
      letterPairCounts[i][j] = 0;
    }
  }

  // Load document; accumulate pair counts. 
  document = loadStrings("dubois.txt"); 
  int nLines = document.length; 
  for (int l=0; l<nLines; l++) {
    String aLine = document[l]; 
    aLine = aLine.toLowerCase(); 
    int nChars = aLine.length(); 
    if (nChars > 1) {
      for (int i=0; i<(nChars-1); i++) {
        char ithChar = aLine.charAt(i  );
        char jthChar = aLine.charAt(i+1);
        if (
          (ithChar >= 'a') && (ithChar <= 'z') &&
          (jthChar >= 'a') && (jthChar <= 'z')) {

          int indexi = (int)(ithChar - 'a'); 
          int indexj = (int)(jthChar - 'a'); 
          letterPairCounts[indexi][indexj]++;
          totalCounts++;
        }
      }
    }
  }

  // Compute max count (for normalization) 
  for (int i=0; i<26; i++) {
    for (int j=0; j<26; j++) {
      if (letterPairCounts[i][j] > maxval) {
        maxval = (float) letterPairCounts[i][j];
      }
    }
  }

}


//=======================================================
void draw(){
  
  int N = 9;
  float margin = width*0.04;
  float rw = (width-margin*2)/26.0; 
  float rh = (height-margin*2)/26.0; 
  float sc = width/(margin + rw*N + rw/2);
  
  background(255); 
  textFont (myNumberFont, 24); 
  for (int i=0; i<N; i++) {
    float rx = map(i, 0, 26, margin, width-margin); 
    for (int j=0; j<N; j++) {
      float ry = map(j, 0, 26, margin, height-margin);
      float val = letterPairCounts[i][j];
      float gray = map(val, 0, maxval, 255, 0); 
      float pct = 100.0*(val/totalCounts);

      fill(gray); 
      noStroke(); 
      rect (rx*sc, ry*sc, rw*sc, rh*sc);
      
      fill(0); 
      if (gray < 40) {
       fill(255);  
      }
      textAlign(CENTER, CENTER); 
      text(nf(pct,0,2), (rx+rw/2)*sc, (ry+rh/2)*sc);
      
    }
  }


  strokeWeight(2.0);
  stroke(0,0,0, 40);
  for (int i=0; i<=N; i++) {
    float rx = map(i, 0, 26, margin, width-margin); 
    line(rx*sc, (margin-rh/4)*sc, rx*sc, (margin+N*rh)*sc); 
  }
  textAlign(CENTER, CENTER); 
  for (int j=0; j<=N; j++) {
    float ry = map(j, 0, 26, margin, height-margin);
    line((margin-rw/4)*sc, ry*sc, (margin+N*rw)*sc, ry*sc);
  }
  
  
  fill(0); 
  textFont (myHeadingFont, 48); 
  textAlign(CENTER, BASELINE); 
  for (int i=0; i<N; i++) {
    float rx = map(i, 0, 26, margin, width-margin); 
    char c = (char)('A'+i);
    text(c, (rx+rw/2)*sc, (margin-rh/4)*sc); 
  }
  textAlign(CENTER, CENTER); 
  for (int j=0; j<N; j++) {
    float ry = map(j, 0, 26, margin, height-margin);
    char c = (char)('A'+j);
    text(c, (margin-rw/2)*sc, (ry+rh/2)*sc); 
  }
  
}

//=======================================================
void keyPressed() {
  if (key == ' '){
    saveFrame("letter_pairs.png"); 
  }
}
