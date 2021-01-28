// Program which flips a coin whenever the user clicks the mouse. 
String theDisplayString = "";
int coinTossCount = 0; 

void setup() {
  size(240, 240);
  tossCoin();
}


void mousePressed() {
  tossCoin();
}

void draw() {
  background(255);
  drawCoin();
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
  ellipse(width/2+6, height/2+1, 120, 120);
  fill(170);
  ellipse(width/2, height/2, 120, 120);

  fill(110);
  text(theDisplayString, width/2-2, height/2-9);
  fill(255, 200);
  text(theDisplayString, width/2, height/2-7);
}

void keyPressed() {
  // saveFrame("../coin_toss.png");
}
