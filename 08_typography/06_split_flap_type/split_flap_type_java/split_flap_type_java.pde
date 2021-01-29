// split_flap_type_java
// It helps to use a monospace font for this.

PFont myFont;  

int nLetters; 
char[] startWord = {'B', 'A', 'R'}; 
char[] endWord   = {'H', 'E', 'N'};
char[] currentWord;
float textY; 
float textX; 

//----------------------------------------
void setup() {
  size(800, 800); 
  frameRate(10); 

  myFont = createFont("LucidaSans-Typewriter", 72);
  textY = 100;
  textX = 88; 
  
  nLetters = startWord.length; 
  currentWord = new char[nLetters]; 
  for (int i=0; i<nLetters; i++) {
    currentWord[i] = startWord[i];
  }
  background(253); 
}

//----------------------------------------
void draw() {

  // render the current word. 
  // as the word changes, move it downwards.
  drawCurrentWord(textX, textY); 
  
  // render the current word large, 
  // in the same spot
  pushMatrix(); 
  translate(width/2, height/2); 
  scale(2, 2); 
  drawCurrentWord(0,0); 
  popMatrix(); 
  
  
  //-------------------------
  // update the current word
  boolean bChanged = false;
  for (int i=0; i<nLetters; i++) {
    if (currentWord[i] < endWord[i]) {
      currentWord[i]++;
      bChanged = true;
    } else if (currentWord[i] > endWord[i]) {
      currentWord[i]--;
      bChanged = true;
    }
  }
  if (bChanged){
    textY += 100; 
    fill(253, 60); 
    rectMode(CORNER);
    rect(0,0, width, height); 
  }
}


//----------------------------------------
void drawCurrentWord(float tx, float ty){
  textFont(myFont, 44*2); 
  textAlign(CENTER, CENTER); 
  rectMode(CENTER); 
  float boxSpacing = 36*2; 
  float boxWidth = boxSpacing-4;
  float boxHeight = 46*2; 
  float textOffsetY = 5*2;
  pushMatrix(); 
  translate(tx, ty); 
  for (int i=0; i<nLetters; i++) {
    float px = i*boxSpacing; 
    float py = 0;
    noStroke(); 
    fill(0, 0, 0); 
    rect(px, py, boxWidth, boxHeight); 
    fill(255); 
    text(currentWord[i], px-1, py - textOffsetY);
  }
  popMatrix(); 
}



//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("split_flap_type.png");
  }
}
