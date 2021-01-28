// Iteration with Randomness

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(160); 
  //draws 50 craters of random diameter and location
  for (int i=0; i<50; i++) {
    float rx = random(-20, width+20); 
    float ry = random(-20, height+20); 
    float rd = random(128); //64 * pow(random(1), 3.0); 
    drawCrater(rx, ry, rd);
  }
}

void drawCrater(float rx, float ry, float rd) {
  //creates concentric, shaded circles to imitate a crater
  noFill();

  strokeWeight(7);
  stroke(0, 0, 0, 10); 
  ellipse(rx-6, ry, rd+5, rd+5);
  stroke(255, 255, 255, 25); 
  ellipse(rx+6, ry, rd+5, rd+5);

  strokeWeight(5);
  stroke(0, 0, 0, 25); 
  ellipse(rx-4, ry, rd+3, rd+3);
  stroke(255, 255, 255, 25); 
  ellipse(rx+4, ry, rd+3, rd+3);

  strokeWeight(4);
  stroke(0, 0, 0, 50); 
  ellipse(rx-3, ry, rd+2, rd+2);
  stroke(255, 255, 255, 50); 
  ellipse(rx+3, ry, rd+2, rd+2);

  strokeWeight(3);
  stroke(0, 0, 0, 75); 
  ellipse(rx-2, ry, rd+1, rd+1);
  stroke(255, 255, 255, 75); 
  ellipse(rx+2, ry, rd+1, rd+1);

  strokeWeight(2);
  stroke(0, 0, 0, 100); 
  ellipse(rx-1, ry, rd+0, rd+0);
  stroke(255, 255, 255, 100); 
  ellipse(rx+1, ry, rd+0, rd+0);
}


void keyPressed() {

  if (key == 's') {
    saveFrame("../iteration_with_randomness.png");
  } else {
    loop(); 
    draw();
    noLoop(); 
  }
}
