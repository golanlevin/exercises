Ring[] rings; // Declare the array
int numRings = 50;
int currentRing = 0;

PImage cursorImg;

void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
  smooth();
  rings = new Ring[numRings]; // Create the array
  for (int i = 0; i < numRings; i++) {
    rings[i] = new Ring(); // Create each object
  }
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("ripple_#####.png");
  } else {
    currentRing = 0; 
    for (int i = 0; i < numRings; i++) {
      rings[i] = new Ring(); // Create each object
    }
  }
}

void draw() {
  background(253); 
  for (int i = 0; i < numRings; i++) {
    rings[i].grow();
    rings[i].display();
  }
  
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}

// Click to create a new Ring
void mousePressed() {
  rings[currentRing].start(mouseX, mouseY);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}

class Ring {
  float x, y; // X-coordinate, y-coordinate
  float diameter; // Diameter of the ring
  boolean on = false; // Turns the display on and off
  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    on = true;
    diameter = 1;
  }
  void grow() {
    if (on == true) {
      diameter += 1.5;
      if (diameter > (width*2*1.414+100)) {
        on = false;
      }
    }
  }
  void display() {
    if (on == true) {
      noFill();
      stroke(0);
      strokeWeight(8);
      ellipse(x, y, diameter, diameter);
    }
  }
 
}
