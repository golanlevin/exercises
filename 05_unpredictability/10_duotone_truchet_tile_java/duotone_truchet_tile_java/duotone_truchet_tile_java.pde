// Duotone Truchet-like Tilings
// Ref: http://cambolbro.com/graphics/duotone/

float n;
float w;

void setup() {
  size(800, 800, FX2D);

  n = 10;
  w = width/n;

  noLoop();
  randomSeed(398);
}

//--------------------------------------------------
void draw() {
  background(253);
  randomSeed(398);

  for (int i = 3; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if ((i+j)%2 == 0) {
        if (round(random(1)) == 0) {
          drawTileA(i*w, j*w, true);
        } else {
          drawTileB(i*w, j*w, false);
        }
      } else {
        if (round(random(1)) == 0) {
          drawTileA(i*w, j*w, false);
        } else {
          drawTileB(i*w, j*w, true);
        }
      }
    }
  }

 drawGrid();
 drawHelper();

}


void drawHelper(){
  
  float sc = 2.0;
  float sep = 1.2;
  pushMatrix();
  scale(sc); 
  translate(16, 16);
  
  drawTileA(0, w*0*sep, true);
  drawTileA(0, w*1*sep, false);
  drawTileB(0, w*2*sep, true);
  drawTileB(0, w*3*sep, false);
  
  strokeWeight(8.0/sc);
  strokeJoin(MITER); 
  stroke(0); 
  noFill(); 
  for (int i=0; i<4; i++) {
    rect(0, w*i*sep, w, w);
  }
  popMatrix();
}

//--------------------------------------------------
void drawGrid() {
  stroke(253, 50);
  strokeWeight(3);
  for (float x = w; x < width; x += w) {
    line(x, 0, x, height);
  }

  for (float y = w; y < height; y += w) {
    line(0, y, width, y);
  }
}

void drawTileA(float x, float y, boolean flip) {
  pushMatrix();
  translate(x, y);
  noStroke();
  if (flip) {
    fill(253);
  } else {
    fill(240); //255, 200, 200);
  }
  rect(0, 0, w, w);
  stroke(0);
  strokeWeight(3);
  if (flip) {
    fill(240); //255, 200, 200);
  } else {
    fill(253);
  }
  arc(w, 0, w, w, HALF_PI, PI);
  arc(0, w, w, w, PI+HALF_PI, PI+PI);
  popMatrix();
}

void drawTileB(float x, float y, boolean flip) {
  pushMatrix();
  translate(x, y);
  noStroke();
  if (flip) {
    fill(253);
  } else {
    fill(240); //255, 200, 200);
  }
  rect(0, 0, w, w);
  stroke(0);
  strokeWeight(3);
  if (flip) {
    fill(240); //255, 200, 200);
  } else {
    fill(253);
  }
  arc(0, 0, w, w, 0, HALF_PI);
  arc(w, w, w, w, PI, PI+HALF_PI);
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("truchet_tile.png");
  }
}
