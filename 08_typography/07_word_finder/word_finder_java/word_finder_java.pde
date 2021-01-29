// Word finder 
//
// Text from "This Is Not a Small Voice" by Sonia Sanchez, 1995
// https://poets.org/poem/not-small-voice


String poem[] = {
  "This is not a small voice", 
  "you hear              this is a large", 
  "voice coming out of these cities.", 
  "This is the voice of LaTanya.", 
  "Kadesha. Shaniqua. This", 
  "is the voice of Antoine.", 
  "Darryl. Shaquille."
};

PFont myFont; 

//------------------------------
void setup() {
  size(800, 800); 
  myFont = createFont("Sentinel-Medium", 60);
}

//------------------------------
void draw() {
  background(253); 
  pushMatrix();
  translate(80, 120); 

  textFont(myFont, 48); 
  textAlign(LEFT, BASELINE); 
  float textSpacing = 96; 

  // Choose the "word of interest"
  String myWord = "voice";
  if (second()%2 == 0) {
    myWord = "This";
  }

  // Display the text. 
  fill(0, 0, 0); 
  for (int i=0; i<poem.length; i++) {
    text(poem[i], 0, i*textSpacing);
  }

  // Find and highlight the word's instances
  noStroke(); 
  fill(200); 
  float wordWidth = textWidth(myWord); 
  for (int i=0; i<poem.length; i++) {
    String aLine = poem[i];
    int wordLoc = aLine.indexOf(myWord); 
    if (wordLoc >= 0) {
      String prefix = aLine.substring(0, wordLoc); 
      float prefixWidth = textWidth(prefix); 
      float px = prefixWidth; 
      float py = i*textSpacing + 4;
      rect(px, py, wordWidth, 14);
    }
  }

  popMatrix();
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("word_finder.png");
  }
}
