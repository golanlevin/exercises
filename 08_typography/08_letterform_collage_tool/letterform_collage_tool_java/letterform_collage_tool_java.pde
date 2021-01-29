// Letter collage 

PFont myFont; 
int whichColor = 0; 
char mostRecentKey = ' '; 
PGraphics pg; 

//=====================================
void setup() {
  size(800, 800); 
  myFont = createFont("Gotham-Black", 456);
  textFont(myFont, 256); 
  textAlign(CENTER, CENTER); 

  pg = createGraphics(800, 800); 
  pg.beginDraw(); 
  pg.textFont(myFont, 256); 
  pg.textAlign(CENTER, CENTER); 
  pg.background(255);
  pg.endDraw();
}

//=====================================
void draw() {
  image(pg, 0, 0); 

  fill (whichColor*255, 64); 
  pushMatrix();
  translate(mouseX, mouseY); 
  text(key, 0, 0);
  popMatrix();
}

//=====================================
void mouseReleased() {
  pg.beginDraw(); 
  pg.fill(whichColor*255); 
  pg.pushMatrix();
  pg.translate(mouseX, mouseY); 
  pg.text(key, 0, 0);
  pg.popMatrix(); 
  pg.endDraw();
}

//=====================================
void keyPressed() {
  if (key == mostRecentKey){
    whichColor = 1-whichColor;
  }
  if (key == ' ') {
    pg.beginDraw(); 
    pg.background(whichColor * 255);
    pg.endDraw();
  } else if (key == TAB){
    saveFrame("letter_collage.png"); 
  }
  mostRecentKey = key; 
}
