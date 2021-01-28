PImage cursorImg;

void setup() {
  size(800, 800, FX2D);
  smooth();
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
}

void draw() {

  background(253);
  ellipseMode(CENTER); 
  strokeWeight(2);
  stroke(0);
  noFill(); 

  int nRows = 14;
  int nCols = nRows;
  float cellSize = (float) width/(nCols+2);
  float eSize = cellSize * 0.75;

  for (int row=1; row<nRows; row++) {
    for (int col=1; col<nCols; col++) {

      float cx = map(col, 0, nCols, 0, width);
      float cy = map(row, 0, nRows, 0, height);  

      float chaos = map(mouseX, 0, width, 0, 1);
      chaos *= pow(map(col, 1, nCols, 0, 1), 1.333); // for photo only
      
      float eRot = HALF_PI + chaos*random(-HALF_PI, HALF_PI);
      float ex = cx + chaos*random(-1,1) * cellSize * 0.5;
      float ey = cy + chaos*random(-1,1) * cellSize * 0.5;
      float eAR = 1 + chaos*random(-0.75, 0.75); 
      float ew = eSize * eAR; 
      float eh = eSize / eAR; 
      
      float esw = 3.0 + chaos*random(-1,1)*2.5; 
      strokeWeight(esw);
    
      pushMatrix(); 
      translate(ex, ey);
      rotate(eRot); 
      ellipse(0, 0, ew, eh); 
      popMatrix();
    }
  }

  for (int i=0; i<17; i++){
    noStroke(); 
    fill(253,253,253, (17-i)*10); 
    ellipse(mouseX+15*1.75, mouseY+21*2.75, i*16,i*16); 
  }
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("order_to_chaos_####.png");
  }
}
