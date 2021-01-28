// Exercises: Arrays
// Living Line 1

PImage cursorImg;
int nPoints = 100;
int xPos[]; 
int yPos[]; 


void setup() {
  size(800, 800);
  smooth(); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png");

  xPos = new int[nPoints];
  yPos = new int[nPoints];
}

void draw() {
  background(253);
  stroke(0, 0, 0); 
  strokeJoin(ROUND);
  strokeWeight(8); 
  
  xPos[nPoints-1]=mouseX; // add new value to the end of the array
  yPos[nPoints-1]=mouseY; // add new value to the end of the array
  for (int i=0; i<(nPoints-1); i++) {
    line(xPos[i], yPos[i], xPos[i+1], yPos[i+1]); 
    xPos[i]=xPos[i+1]; // move each value along the array
    yPos[i]=yPos[i+1]; // move each value along the array
  }

  // draw the cursor (for screenshots only)
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}


void keyPressed() {
  saveFrame("livingline_####.png");
  for (int i=0; i<nPoints; i++) {
    xPos[i]=mouseX; // move each value along the array
    yPos[i]=mouseY;
  }
}
