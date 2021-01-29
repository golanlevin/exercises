// Responsive Text (mouse-sensitive): TICKLE

PFont myRegularFont;  
PFont myItalicFont; 
PImage cursorImg;
String theWord;
float tx, ty; // current text coordinates
float ux, uy; // target coordinates

//----------------------------------------
void setup() {
  size(800, 800); 

  myRegularFont = createFont("Helvetica-Bold", 72);
  myItalicFont = createFont("Helvetica-BoldOblique", 72);
  cursorImg = loadImage("cursor_with_shadow_15x21.png");  
  theWord = "avoid"; 

  ux = tx = width/2;
  uy = ty = height/2;
}

//----------------------------------------
void draw() {
  noStroke();
  fill(253, 50);
  rect(0, 0, width, height); 

  // Compute the text's bounding box
  float rw = textWidth(theWord); 
  float rh = textAscent() + textDescent();
  float rx = tx - rw/2;
  float ry = ty - rh/2;

  // Check to see if the mouse is in the box,
  // and update the text's target position.
  boolean bMoving = false; 
  if ((mouseX > rx) && (mouseX < (rx+rw)) && 
    (mouseY > ry) && (mouseY < (ry+rh))) {
    float dx = (mouseX - tx); 
    float dy = (mouseY - ty);
    float avoidAmount = 1.2; 
    ux = tx - avoidAmount * dx;
    uy = ty - avoidAmount * dy;
    bMoving = true; 
  }
  
  // Draw the text
  if (bMoving){
    textFont(myItalicFont, 144); 
  } else {
    textFont(myRegularFont, 144); 
  }
  textAlign(CENTER, CENTER); 
  fill(0, 0, 0); 
  text(theWord, tx, ty); 

  
  // Interpolate the text position to target position, 
  // using Zeno's method (simple easing)
  float A = 0.96; 
  float B = 1.0-A;
  tx = A*tx + B*ux;
  ty = A*ty + B*uy;

  // Draw the cursor (for print output)
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("responsive_text.png");
  } else {
    background(253); 
    ux = tx = width/2;
    uy = ty = height/2;
  }
}
