
String[] words;
PFont myFont; 

void setup(){
  size(800, 800); 
  myFont = createFont("Century", 64); 
  
  words = new String[3]; 
  words[0] = "perspicacious";
  words[1] = "polyphiloprogenitive";
  words[2] = "piglet";
}

void draw(){
  background(253); 
  
  float margin = 40; 
  float targetTextWidth = width - 2*margin;
  
  // draw borders
  noFill(); 
  stroke(0); 
  strokeWeight(2);
  line(margin-3, margin, margin-3, height-margin); 
  line(width-margin+3, margin, width-margin+3, height-margin); 
  
  float y = margin+50;
  
  textAlign(CENTER, TOP);
  fill(0); 
  
  int nWords = words.length;
  for (int i=0; i<nWords; i++){
    String word = words[i]; 
    float wordFontSize = 1.0; 
    textFont(myFont, wordFontSize); 
    while (textWidth(word) < targetTextWidth){
      wordFontSize += 0.01; 
      textFont(myFont, wordFontSize); 
    }
    text(word, width/2, y); 
    y += wordFontSize * 1.2;
  }
  
}

void keyPressed(){
  saveFrame("procrustean_typography.png"); 
}
