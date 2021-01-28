float theta;   

void setup() {
  size(800, 800);
  background(253);
  stroke(0);
  strokeWeight(3);
  drawTree();
}

void draw() {
}

void drawTree() {
  background(253);

  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = 30;
  // Convert it to radians
  theta = radians(a);
  // Start the tree from the bottom of the screen
  translate(width/2,height);
  // Draw a line 120 pixels
  line(0,0,0,-200);
  // Move to the end of that line
  translate(0,-200);
  // Start the recursive branching!
  branch(height/3);
}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= map(random(1), 0, 1, 0.5, 0.8); // INTRODUCE RANDOMNESS
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 4) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    
    float theta_2 = map(random(1), 0, 1, 0.7*theta, 2*theta);
    rotate(theta_2);   // Rotate by theta // INTRODUCE RANDOMNESS
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    float theta_3 = map(random(1), 0, 1, 0.7*theta, 2*theta);
    rotate(-theta_3); // INTRODUCE RANDOMNESS
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("recursive_tree.png");
  } else {
    drawTree();
  }
}
