// The raindrop catching game

Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Drop[] drops;       // An array of drop objects
int totalDrops = 0; // totalDrops

PImage cursorImg; 

void setup() {
  size(800, 800);
  catcher = new Catcher(120); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(100);    // Create a timer that goes off every 300 milliseconds
  timer.start();             // Starting the timer
  
  cursorImg = loadImage("cursor_with_shadow_15x21.png"); 
}

void draw() {
  background(253);

  // Set catcher location
  catcher.setLocation(mouseX, mouseY); 
  // Display the catcher
  catcher.display1(); 

  // Check the timer
  if (timer.isFinished()) {
    // Deal with raindrops
    // Initialize one drop
    drops[totalDrops] = new Drop();
    // Increment totalDrops
    totalDrops ++ ;
    // If we hit the end of the array
    if (totalDrops >= drops.length) {
      totalDrops = 0; // Start over
    }
    timer.start();
  }

  // Move and display all drops
  for (int i = 0; i < totalDrops; i++ ) {
    drops[i].move();
    drops[i].display();
    if (catcher.intersect(drops[i])) {
      drops[i].caught();
    }
  }
  
  catcher.display2(); 
  image(cursorImg, mouseX, mouseY+60, 15*6, 21*6); 
}

void keyPressed(){
  if (key == ' ') {
    saveFrame("raindrop_####.png");
  }
}
