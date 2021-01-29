// Dynamic Text (text over time): GROW

PFont myFont;  
float tSize;
float tPos; 

//----------------------------------------
void setup() {
  size(800, 800); 
  myFont = createFont("Georgia", 96);

  background(253);
  tSize = 10;
  tPos = height * 0.8;
}

//----------------------------------------
void draw() {
  if (frameCount < 50) {
    tSize *= 1.05;
    tPos = tPos - 6.0;

    noStroke(); 
    fill(255, 255, 255, 20); 
    rect(0, 0, width, height); 

    textFont(myFont, tSize); 
    textAlign(CENTER); 
    fill(0);
    drawWord();
    ;
  } else if (frameCount == 50) {
    fill(255);
    textFont(myFont, tSize); 
    textAlign(CENTER); 
    text("GROW", 400, tPos);
  }
}

//----------------------------------------
void drawWord() {
  for (int dy=-2; dy<=2; dy+=2) {
    for (int dx=-2; dx<=2; dx+=2) {
      text("GROW", width/2-dx, tPos+dy);
    }
  }
}

//----------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("text_with_feeling.png");
  }
}
