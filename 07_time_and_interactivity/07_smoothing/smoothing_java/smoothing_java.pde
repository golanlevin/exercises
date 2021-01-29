float mx[];
float my[]; 

void setup() {
  size(400, 400); 
  mx = new float[100];
  my = new float[100];
}

void mousePressed() {
  background(255);
  for (int i=0; i<100; i++) {
    mx[i] = mouseX;
    my[i] = mouseY;
  }
}

void draw() {
  noStroke(); 
  fill(255, 255, 255, 20); 

  rect(0, 0, width, height); 

  noFill(); 
  stroke(0); 
  strokeWeight(2);
  beginShape();
  for (int i=0; i<100; i++) {
    vertex(mx[i], my[i]);
  }
  endShape(); 

  if (mousePressed) {
    for (int i=0; i<99; i++) {
      mx[i] = mx[i+1];
      my[i] = my[i+1];
    }
    mx[99] = mouseX; 
    my[99] = mouseY;
  } else {
    for (int i=1; i<99; i++) {
      mx[i] = (mx[i-1] + mx[i] + mx[i+1])/3.0;
      my[i] = (my[i-1] + my[i] + my[i+1])/3.0;
    }
  }
}

void keyPressed(){
  background(255);
  mx = new float[100];
  my = new float[100];
}
