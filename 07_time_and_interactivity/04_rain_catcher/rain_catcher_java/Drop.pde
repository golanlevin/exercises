// Example 10-10: The raindrop catching game

class Drop {
  float x, y;   // Variables for location of raindrop
  float speed;  // Speed of raindrop
  color c;
  float r;      // Radius of raindrop
  float size;

  Drop() {
    r = 8;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*10;                // Start a little above the window
    speed = random(1, 5);    // Pick a random speed
    c = color(0,0,0);//50, 100, 150); // Color
    
    size = 30;
  }

  // Move the raindrop down
  void move() {
    // Increment by speed
    y += speed;
  }

  /*
  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }
  */

  // Display the raindrop
  void display() {
    // Display the drop
    fill(c);
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(-QUARTER_PI/2);
    bezier(size/2, 0,  0,  size,  0, size*2,  size/2, size*2);
    bezier(size/2, 0,  size,  size,  size, size*2,  size/2, size*2);
    popMatrix();
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    y = -1000;
  }
}
