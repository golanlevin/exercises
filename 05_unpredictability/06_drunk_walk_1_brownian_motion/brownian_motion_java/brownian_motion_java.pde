float px; 
float py; 

void setup() {
  size(800, 800, FX2D);  
  smooth(); 
  reset();
}

void draw() {

  stroke(0); 
  strokeWeight(2); 
  for (int i=0; i<10; i++) {
    float qx = px;
    float qy = py; 
    float jumpRange = 20; 
    float rangle = random(0, TWO_PI); 
    px += jumpRange * cos(rangle); //random(-1, 1); 
    py += jumpRange * sin(rangle); //random(-1, 1);

    stroke(0); 
    strokeWeight(2); 
    line (qx, qy, px, py);
  }
}

void keyPressed() {
  if (key == 'R') {
    reset();
  } else if (key == ' ') {
    println("saving " + millis()); 
    saveFrame("brownian_motion_#####.png");
  }
}

void reset() {
  background(253);
  px = width/2; 
  py = height/2;
}
