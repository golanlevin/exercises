//import java.lang.Comparable;
//import java.util.Comparator;
import java.util.Collection.*;

PFont myFont; 
String document = "All human beings are born free and equal in dignity and rights. They are endowed with reason and conscience and should act towards one another in a spirit of brotherhood.";
ArrayList<String> tokensArrayList;


void setup() {
  size(800, 800);
  // noLoop(); 
  myFont = createFont("Century", 64); 

  String tokens[] = splitTokens(document, "-,. "); 
  tokensArrayList = new ArrayList<String>();
  for (int i=0; i<tokens.length; i++) {
    tokens[i] = tokens[i].toLowerCase(); 
    tokensArrayList.add(tokens[i]);
  }
  java.util.Collections.sort(tokensArrayList);

}
//----------------------------------------
void draw() {
  ;

  background(255); 
  fill(0); 
  textFont (myFont, 72);
   

  float margin = 50; 
  float tx = margin; 
  float ty = 92; 
  for (int i=0; i<tokensArrayList.size(); i++) {
    String aWord = tokensArrayList.get(i); 
    float wordWidth = textWidth(aWord) + textWidth(" ") + 10.5; 
    if ((tx + wordWidth) > (width - margin)) {
      tx = margin; 
      ty += 72;
    } 
    text(aWord, tx, ty);
    tx += wordWidth;
  }
}


//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("sorting_words.png");
  }
}
