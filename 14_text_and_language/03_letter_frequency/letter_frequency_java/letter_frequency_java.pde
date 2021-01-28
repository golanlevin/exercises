String document[]; 
int letterFrequencyCounts[];
PFont myFont; 

void setup() {
  size(800, 800);
  noLoop(); 
  
  myFont = createFont("BellCentennialStd-NameNum", 37); 
  textFont (myFont); 

  // Initialize letterFrequencyCounts
  letterFrequencyCounts = new int[26]; 
  for (int i=0; i<26; i++) {
    letterFrequencyCounts[i] = 0;
  }

  // Load document; accumulate letter counts. 
  document = loadStrings("frankenstein.txt"); 
  int nLines = document.length; 
  for (int l=0; l<nLines; l++) {
    String aLine = document[l]; 
    aLine = aLine.toLowerCase(); 
    int nChars = aLine.length(); 
    for (int i=0; i<nChars; i++) {
      char ithChar = aLine.charAt(i); 
      if ((ithChar >= 'a') && (ithChar <= 'z')) {
        int charIndex = (int)(ithChar - 'a'); 
        letterFrequencyCounts[charIndex]++;
      }
    }
  }

  // Compute max letter count (for normalization)
  int maxval = 0; 
  for (int i=0; i<26; i++) {
    if (letterFrequencyCounts[i] > maxval) {
      maxval = letterFrequencyCounts[i];
    }
  }

  // Display histogram of letterFrequencyCounts
  background(255); 
  for (int i=0; i<26; i++) {
    int ithCount = letterFrequencyCounts[i];
    
    float rw = width/(26+2.0); 
    float rx = map(i, 0, 25, rw, width-rw*2); 
    float ry = height-rw*2.25; 
    float rh = 0-map(ithCount, 0, maxval, 0, height-3.5*rw); 
    
    noStroke(); 
    fill(64);
    rect(rx, ry, rw-2, rh); 

    fill(0); 
    textAlign(CENTER, TOP); 
    text(char(i+'A'), rx+rw/2-1, ry+10);
  }
}

//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("letter_frequency.png");
  }
}

//----------------------------------------
void draw() {
  ;
}
