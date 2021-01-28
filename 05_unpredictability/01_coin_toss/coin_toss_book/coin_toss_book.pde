// Program which flips a coin whenever the user clicks the mouse. 
String theDisplayString = "";
int coinTossCount = 0; 

void setup() {
  size(800, 800);
  tossCoin();
}


void mousePressed() {
  tossCoin();
}

void draw() {
  background(253);
  pushMatrix(); 
  translate(width/2, height/2); 
  scale(800.0/240.0); 
  drawCoin();
  popMatrix(); 
}

void tossCoin() {
  // Generate a random number between 0 and 1
  coinTossCount++; 
  float aRandomValue = random(1.0);

  if (aRandomValue < 0.5) {
    theDisplayString = "T";
    println("Coin toss #" + coinTossCount + ": (T)ails"); 
  } else {
    theDisplayString = "H";
    println("Coin toss #" + coinTossCount + ": (H)eads"); 
  }
}


void drawCoin() {
  textAlign(CENTER, CENTER);
  textSize(80);
  
  noStroke();
  fill(100); 
  ellipse(0+6, 0+1, 120, 120);
  fill(170);
  ellipse(0, 0, 120, 120);

  fill(110);
  text(theDisplayString, 0-2, 0-9);
  fill(255, 200);
  text(theDisplayString, 0, 0-7);
}

void keyPressed() {
  saveFrame("coin_toss.png");
}
