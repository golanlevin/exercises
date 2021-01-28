char mode;

PVector cp1 = new PVector(300, 100);
PVector p1 = new PVector(750, 200);

PVector cp2 = new PVector(300, 500);
PVector p2 = new PVector(400, 450);

PVector cp3 = new PVector(500, 400);
PVector p3 = new PVector(400, 450);

void setup() {
  size(800, 800);
  strokeWeight(8);
  stroke(0);
  smooth();
  noFill();
  mode = ' ';
  frameRate(100);
}

void draw() {
  background(253);

  noFill();

  if (mode == '1') {
    p1 = new PVector(mouseX, mouseY);
  } else if (mode == '2') {
    p2 = new PVector(mouseX, mouseY);
  } else if (mode == '3') {
    p3 = new PVector(mouseX, mouseY);
  } else if (mode == 'a') {
    cp1 = new PVector(mouseX, mouseY);
  } else if (mode == 'b') {
    cp2 = new PVector(mouseX, mouseY);
  } else if (mode == 'c') {
    cp3 = new PVector(mouseX, mouseY);
  }

  PVector cp2_ = new PVector(p2.x + (p2.x - cp2.x), p2.y + (p2.y - cp2.y));

  stroke(0); 
  strokeWeight(3);
  line(cp1.x, cp1.y, p1.x, p1.y);
  line(cp2.x, cp2.y, cp2_.x, cp2_.y);
  line(cp3.x, cp3.y, p3.x, p3.y);
  strokeWeight(8);
  bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y);
  bezier(p2.x, p2.y, cp2_.x, cp2_.y, cp3.x, cp3.y, p3.x, p3.y);



  int R = 32;
  int r = 24; 

  stroke(0); 
  strokeWeight(8);
  fill(255, 200, 200);
  ellipse(cp1.x, cp1.y, R, R);
  ellipse(cp2.x, cp2.y, R, R);
  ellipse(cp2_.x, cp2_.y, R, R);
  ellipse(cp3.x, cp3.y, R, R);

  fill(0); 
  noStroke(); 
  ellipse(p1.x, p1.y, r, r);
  ellipse(p2.x, p2.y, r, r);
  ellipse(p3.x, p3.y, r, r);
}

//-----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("bezier.png");
  } else {
    mode = key;
    print(mode);
  }
}
