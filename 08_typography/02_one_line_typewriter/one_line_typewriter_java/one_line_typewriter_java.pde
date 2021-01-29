PFont myFont;
String typedText = "type:"; 

void setup() {
  size(800, 800); 
  myFont = createFont("Courier-Bold", 72);
}


void draw() {
  background(253); 
  fill(0); 
  
  float textX = width * 0.925;
  float textY = height/2 - 5;

  textFont(myFont, 72); 
  textAlign(RIGHT, CENTER); 
  text(typedText, textX, textY);
  
  // draw a very simple text-cursor 
  stroke(0); 
  strokeWeight(8); 
  line(textX, textY+50, textX, textY-45); 
}


void keyPressed() {
  if (key == TAB){
    saveFrame("one_line_typewriter.png"); 
  } else  if ((key == RETURN) || (key == ENTER)) {
    typedText = "";
  } else if (key == BACKSPACE) {
    int len = typedText.length();
    if (len > 0) {
      typedText = typedText.substring(0, len-1);
    }
  } else if ((key >= 20) && (key <= 126)){
    typedText += key;
  }
}
