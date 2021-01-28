
PImage sourceImg;
PImage cursorImg; 
PFont myFont; 

//------------------------------------
void setup() {
  size(800, 800);
  sourceImg = loadImage("monet_haystack.jpg"); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
  myFont = createFont("Helvetica-Bold", 60);
}

//------------------------------------
void draw() {
  background(253); 
  textFont(myFont, 60); 

  image(sourceImg, 0, 0, 800, 629); 
  color col = get(mouseX, mouseY); 
  int colr = (int) red(col); 
  int colg = (int) green(col); 
  int colb = (int) blue(col); 

  fill(col); 
  noStroke(); 
  float m = 24; 
  float eh = (height-629)-2*m;
  println(eh); 
  rect(m, 629+m, eh, eh, m); 

  ellipseMode(CENTER); 
  noStroke(); 
  float ew = (width - eh - 2*m)/3 - m;
  fill(colr, 0, 0); 
  ellipse(m+eh+m+ew/2, 629+m+ eh/2, ew, eh); 
  fill(0, colg, 0); 
  ellipse(m+eh+m+ew+m+ew/2, 629+m+ eh/2, ew, eh); 
  fill(0, 0, colb); 
  ellipse(m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2, ew, eh); 

  fill(255); 
  textAlign(CENTER, CENTER); 
  text(colr, m+eh+m+ew/2, 629+m+ eh/2 - 4); 
  text(colg, m+eh+m+ew+m+ew/2, 629+m+ eh/2 - 4); 
  text(colb, m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2 - 4); 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("color_inspector.png");
  }
}
