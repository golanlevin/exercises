PFont myFont; 
String typed = "";
ColorString[] myColorStrings;

//-------------------------------------
void setup() {
  size(800, 800, FX2D); 
  myFont = createFont("Century", 96); 
  textFont(myFont, 96); 
  
  myColorStrings = new ColorString[4];
  myColorStrings[0] = new ColorString("red", 0xFFFF0000);
  myColorStrings[1] = new ColorString("green", 0xFF00A000);
  myColorStrings[2] = new ColorString("blue", 0xFF5050FF);
  myColorStrings[3] = new ColorString("purple", 0xFF300090);
}

//-------------------------------------
void draw() {
  background(255); 
  noStroke(); 
  fill(0); 
  textAlign(CENTER); 
  text(typed, width/2, 200);
  
  pushMatrix();
  scale(2.0); 
  String lowerTyped = typed.toLowerCase(); 
  for (int i=0; i<myColorStrings.length; i++){
    String s = myColorStrings[i].s;
    if (lowerTyped.contains(s)){
      fill(myColorStrings[i].c); 
    }
  }
  rect(100, 150, 200, 200, 20);
  popMatrix(); 
}

//-------------------------------------
void keyPressed() {
  if ((key == ENTER) || (key == RETURN)){
    typed = "";
  } else if (key == TAB){
    saveFrame("string_search.png"); 
  } else {
    if ((key >= 32) && (key < 127)) {
      typed += key;
    }
  }
}

//-------------------------------------
class ColorString {
  color c; 
  String s; 
  ColorString (String ins, color inc) {
    s = ins; 
    c = inc;
  }
}
