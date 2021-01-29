ArrayList<PVector> moles_list;
int n;
int score;
float lastTime_add;
float lastTime_remove;
float wait_add;
float wait_remove;

PFont myFont; 

void setup() {
  size(800, 800);
  n = 3;
  score = 0;
  moles_list = new ArrayList<PVector>();
  lastTime_add = 0;
  lastTime_remove = 2000;
  wait_add = 300;
  wait_remove = 500;

  myFont = createFont("Helvetica-Bold", 72); 
  textFont(myFont, 72);
}

void draw() {
  background(253);
  drawGrid();
  drawMoles();
  drawScore();
  addMoles();
}

void drawGrid() {
  ellipseMode(CENTER);
  fill(160);
  stroke(0); 
  strokeWeight(8); 

  int index = 0; 
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (index > 0) {
        float x = ((i+0.5)/n)*width;
        float y = ((j+0.8)/n)*height;
        ellipse(x, y, width/n * 3/4, height/n / 4);
      }
      index++;
    }
  }
}

void drawMoles() {

  rectMode(CENTER);
  ellipseMode(CENTER);

  for (int i = 0; i < moles_list.size(); i++) {
    PVector m = moles_list.get(i);
    float x = ((m.x+0.5)/n)*width;
    float y = ((m.y+0.6)/n)*height; 
    int size = width/n;

    noFill(); 
    strokeWeight(16); 
    stroke(0); 
    ellipse(x, y-size/4, size/2, size/2);//, 0, PI+2*PI, OPEN);
    rect(x, y, size/2, size/2);
    ellipse(x, y+size/4+2, size/2, size/9); 

    fill(255, 200, 200);
    noStroke(); 
    ellipse(x, y-size/4, size/2, size/2);//, 0, PI+2*PI, OPEN);
    rect(x, y, size/2, size/2);
    ellipse(x, y+size/4+2, size/2, size/9); 

    //// ears
    //ellipse(x-size/4, y-size/2, size/5, size/5);
    //ellipse(x+size/4, y-size/2, size/5, size/5);

    // eyes
    fill(255);
    ellipse(x-size/8, y-size/4, size/6, size/6);
    ellipse(x+size/8, y-size/4, size/6, size/6);
    fill (0);
    float tilt = 0;
    if (mouseX < x) {
      tilt = -5;
    } else {
      tilt = 5;
    }
    ellipse(x-size/8+tilt, y-size/4, size/12, size/12);
    ellipse(x+size/8+tilt, y-size/4, size/12, size/12);
  }
}

void drawScore() {
  textAlign(CENTER, TOP);
  fill(0);
  textFont(myFont, 72); 
  text("score:", 133,16);
  textFont(myFont, 96); 
  text(score, 133,92);
}

void addMoles() {
  if (((millis() - lastTime_add) > wait_add)  && (random(1) < 0.1)) {
    int x = floor(random(1) * n);
    int y = floor(random(1) * n);
    if (!((x == 0) && (y == 0))) {
      if (isMole(x, y) == -1) {
        moles_list.add(new PVector(x, y));
      }
      lastTime_add = millis();
    }
  }

  // remove mole
  if ((millis() - lastTime_remove) > wait_remove 
    && random(1) < 0.01
    && moles_list.size() > 0) {
    int pick = floor(random(moles_list.size()));
    moles_list.remove(pick);
    lastTime_remove = millis();
  }

  if (moles_list.size() > 5) {
    moles_list.remove(0);
  }
}

void mousePressed() {
  int c = floor(mouseX * n/width);
  int r = floor(mouseY * n/height);

  int hitMole = isMole(c, r);
  if (hitMole != -1) {
    score += 1; 
    moles_list.remove(hitMole);
  }
}

int isMole(int x, int y) {
  for (int i = 0; i < moles_list.size(); i++) {
    PVector m = moles_list.get(i);
    if (m.x == x && m.y == y) {
      // hit a mole! 
      return i;
    }
  }
  return -1;
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("whack_a_mole.png");
  }
}
