PImage head;
PImage body;
PImage feet;

void setup() {
  size(300, 300);
  drawBackground(); 
  makeNewExquisiteCorpse();
}

void draw() {
}

void mousePressed() {
  drawBackground();
  makeNewExquisiteCorpse();
}


void makeNewExquisiteCorpse() {
  
  int numParts = 5;
  head = loadImage("head" + str(int(random(numParts))+1) + ".png"); 
  body = loadImage("body" + str(int(random(numParts))+1) + ".png");
  feet = loadImage("feet" + str(int(random(numParts))+1) + ".png");

  image(head, 0, 0);
  image(body, 0, 0);
  image(feet, 0, 0);
}


void drawBackground() {
  background(255);
  noStroke();

  fill(250);
  rect(0, 0*height/3, width, height/3);
  fill(230);
  rect(0, 1*height/3, width, height/3);
  fill(250);
  rect(0, 2*height/3, width, height/3);
}

void keyPressed() {
  saveFrame("../exquisite_corpse.png");
}