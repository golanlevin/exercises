float px, py; 
float qx, qy; 
boolean bFirst = true; 
boolean bDoCapture = false; 

void setup() {
  size(800, 800);
  background(253); 
}

void draw() {
  fill(253, 6); 
  noStroke();
  rect(0, 0, width+1, height+1); 
  
  float t = frameCount/60.0; 
  float A = 3.0; 
  float B = 2.0;
  px = width/2  + 300 * cos(A*t); 
  py = height/2 + 300 * sin(B*t);
  if (bFirst) {
    background(253); 
    qx = px; 
    qy = py;
    bFirst = false;
  }

  noFill(); 
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  line(px, py, qx, qy); 
  qx = px; 
  qy = py;

  if (bDoCapture) {
    fill(255, 200, 200); 
    stroke(0); 
    strokeWeight(8); 
    ellipse(px, py, 60, 60);
    saveFrame("lissajous_####.png");
    bDoCapture = false;
    bFirst = true;
  }
}

void keyPressed() {
  if (key == ' ') {
    bDoCapture = true; 
  }
}
