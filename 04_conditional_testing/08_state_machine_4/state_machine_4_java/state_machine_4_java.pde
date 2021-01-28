// Place a white square on a gray background. 
// Turn the square into a button with a "hover" state: 
// make it white when inactive, yellow when the user is 
// hovering over it (without having clicked), and black 
// when the user is actively holding the mouse button down inside of it.
int state;

int ACTIVE = 0; 
int INACTIVE = 1; 
int HOVER = 2;

float rW, rH, rT, rL, rR, rB;
float rectSize; 
PImage cursorImg; 

void setup() {
  size(800, 800);
  rectMode(CORNER);
  rectSize = width * (1.0 - ((sqrt(5) - 1.0)/2.0));
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  state = INACTIVE; 
}

void draw() {
  background(200);

  rW = rectSize; 
  rH = rectSize;  
  rL = width/2 - rectSize/2; 
  rT = height/2 - rectSize/2;
  rR = rL + rW; 
  rB = rT + rH; 
  
  if ((mouseX > rL) && (mouseX < rR) && (mouseY < rB) && (mouseY > rT)) {
    if (mousePressed){
      state = ACTIVE; 
    } else {
      state = HOVER; 
    }
  } else {
    state = INACTIVE; 
  }
  
  
  
  

  if (state == ACTIVE) {
    fill(50);
  } else if (state == INACTIVE){
    fill(255); 
  } else if (state == HOVER){
    fill (255, 248, 162); 
  }

  stroke(0); 
  strokeWeight(8); 
  strokeJoin(MITER); 
  rect(rL, rT, rW, rH);
  
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("state_machine.png");
  }
}
