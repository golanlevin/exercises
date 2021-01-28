PImage cursorImg; 
PFont myFont; 

void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
  myFont = createFont("CenturySchoolbook", 90); 
}

void draw() {
  background(253);
  String str = (mouseX > (width/2)) ? "RIGHT" : "LEFT";
  
  stroke(0); 
  strokeWeight(8); 
  strokeCap(ROUND); 
  for (float y=-10; y<(height * 0.666); y+=80){
    line(width/2, y, width/2, y+45); 
  }
  
  
  fill(0); 
  textAlign(CENTER, CENTER); 
  textFont(myFont, 90); 
  textLeading(90); 
  text("Cursor is on the\n" + str, width*0.50, height*0.80); 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("left_or_right.png");
  }
}
