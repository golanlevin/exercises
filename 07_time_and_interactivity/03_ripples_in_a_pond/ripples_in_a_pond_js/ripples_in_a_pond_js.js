var rings = []; // Declare the array
var numRings = 50;
var currentRing = 0;

function setup() {
  createCanvas(300, 300);
  smooth();
  // rings = new Ring[numRings]; // Create the array
  for (var i = 0; i < numRings; i++) {
    rings[i] = new Ring(); // Create each object
  }
}

function draw() {
  background(251,128,114);
  for (var i = 0; i < numRings; i++) {
    rings[i].grow();
    rings[i].display();
  }
}

// Click to create a new Ring
function mousePressed() {
  rings[currentRing].start(mouseX, mouseY);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}

class Ring {
  constructor(x, y, diameter, on) {
    this.x = x; // X-coordinate
    this.y = y; // y-coordinate
    this.diameter = diameter; // Diameter of the ring
    this.on = false; // Turns the display on and off
  }
  
  start(xpos, ypos) {
    this.x = xpos;
    this.y = ypos;
    this.on = true;
    this.diameter = 1;
  }
    
  grow() {
    if (this.on == true) {
      this.diameter += 1.5;
      if (this.diameter > 400) {
        this.on = false;
      }
    }
  }
  
    display() {
    if (this.on == true) {
      noFill();
      strokeWeight(4);
      stroke(255, 153);
      ellipse(this.x, this.y, this.diameter, this.diameter);
    }
  }
}