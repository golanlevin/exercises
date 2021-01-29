void setup() {
  size(800, 800);
  background(255);
  strokeWeight(3);
  stroke(0);
}

void keyPressed() {
  switch (key) {
  case 'a':
    fill(255, 200, 200); 
    float ex = width * random(0.2, 0.8);
    float ey = height * random(0.2, 0.8);
    float ed = width * random(0.2, 0.5); 
    ellipse(ex, ey, ed, ed); 
    break;

  case 'b':
    fill(200, 210, 255); 
    rectMode(CENTER); 
    float rx = width * random(0.2, 0.8);
    float ry = height * random(0.2, 0.8);
    float rw = width * random(0.2, 0.5); 
    float rh = height * random(0.2, 0.5); 
    rect(rx, ry, rw, rh); 
    break;

  case 'c':
    fill(255); 
    float cx = width * random(0.1, 0.6);
    float cy = height * random(0.1, 0.9);
    int nc = (int) random(3, 8); 
    for (int i=0; i<nc; i++) {
      float dx = i*50; 
      ellipse(cx + dx, cy, 40, 40);
    }

    break;
  }
}

void draw() {
}

void mousePressed() {
  // saveFrame();
  background(255);
}
