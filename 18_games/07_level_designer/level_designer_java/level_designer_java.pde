PVector dims;
int[][] map;
int selectX;
int selectY;

final int LAND = 100;
final int WATER = 101;
final int TREASURE = 102;

int mode;

PFont myFont; 


void setup() {
  size(800, 800);
  int diamonds = 6;
  dims = new PVector(diamonds, diamonds*4);
  map = new int[int(dims.y)][int(dims.x)];
  
  for (int i = 0; i < dims.y; i++) {
    for (int j = 0; j < dims.x; j++) {
      map[i][j] = LAND;  
    }
  }
  
  mode = LAND;
  
  selectX = 2;
  selectY = 2;
  
  myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 60);
}

void draw() {
  background(253);
  drawMap();
  //drawGuide();
}

void drawMap() {
  float w = width/(dims.x-2);
  float h = w/2;
  for (int i = 0; i < dims.y; i++) {
    for (int j = 0; j < dims.x; j++) {
      stroke(255);
      strokeWeight(8);
      float x = (j-1)*w;
      float y = (i-1)*h / 2.0;
      if (i%2 == 1) {
        x += w/2;
      }
      if (map[i][j] == LAND) {
        fill(10, 200, 50);
        quad(x, y+h/2, x+w/2, y, x+w, y+h/2, x+w/2, y+h);
        grass(x+w/2, y+h/2, h/2);

      } else if (map[i][j] == WATER) {
        fill(50, 50, 200);
        quad(x, y+h/2, x+w/2, y, x+w, y+h/2, x+w/2, y+h);
        water(x+w/2, y+h/2, h/2);

      } else if (map[i][j] == TREASURE) {
        fill(255, 200, 200);
        quad(x, y+h/2, x+w/2, y, x+w, y+h/2, x+w/2, y+h);
        star(x+w/2, y+h/2, h/4, h/8, 5); 

      } else {
        fill(200);
        quad(x, y+h/2, x+w/2, y, x+w, y+h/2, x+w/2, y+h);
      }
    }
  }
  
  // draw selected tile
  noFill();
  stroke(0);
  float x = (selectX-1)*w;
  float y = (selectY-1)*h / 2.0;
  if (selectY%2 == 1) {
    x += w/2;
  }
  quad(x, y+h/2, x+w/2, y, x+w, y+h/2, x+w/2, y+h);
  
}

void drawGuide() {
  noStroke();
  fill(253);
  rect(0, 0, width, 80);
  
  float x = 0;
  float y = 0;
  float w = width/dims.x;
  float h = w;
  
  textAlign(LEFT, BOTTOM);
  fill(0, 255, 0);
  quad(x, y+h/4, x+w/2, y, x+w, y+h/4, x+w/2, y+h/2);

  fill(0);
  text("Land", x+w*2/3, y+h/2+4);
  
  x += w*2;
  fill(50, 50, 255);
  quad(x, y+h/4, x+w/2, y, x+w, y+h/4, x+w/2, y+h/2);
  fill(0);
  text("Water", x+w*2/3, y+h/2+4);
  
  x += w*2;
  fill(255, 200, 200);
  quad(x, y+h/4, x+w/2, y, x+w, y+h/4, x+w/2, y+h/2);
  fill(0);
  text("Treasure", x+w*2/3, y+h/2+4);
  
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  noStroke();
  fill(255);
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void water(float x, float y, float r) {
  strokeWeight(3);
  noFill();
  pushMatrix();
  translate(x-r*2/3, y+r/4);
  beginShape();
  curveVertex(0,  0);
  curveVertex(0,  0);
  curveVertex(10,  -5);
  curveVertex(20,  0);
  curveVertex(30,  -5);
  curveVertex(40,  0);
  curveVertex(50,  -5);
  curveVertex(60,  0);
  curveVertex(60,  0);
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(x-r/2, y-r/4);
  beginShape();
  curveVertex(0,  0);
  curveVertex(0,  0);
  curveVertex(r*1/5,  -r/10);
  curveVertex(r*2/5,  0);
  curveVertex(r*3/5,  -r/10);
  curveVertex(r*4/5,  0);
  curveVertex(r*5/5,  -r/10);
  curveVertex(r*6/5,  0);
  curveVertex(r*6/5,  0);
  endShape();
  popMatrix();
}

void grass(float x, float y, float r) {
  strokeWeight(3);
  stroke(0, 150, 0);
  noFill();
  pushMatrix();
  translate(x-r*2/3, y-r/8);
  beginShape();
  curveVertex(0,  0);
  curveVertex(0,  0);
  curveVertex(r*1/5,  r*1/5);
  curveVertex(r*3/10,  r*2/5);
  curveVertex(r*3/10,  r*2/5);
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(x - r/8, y-r/8);
  beginShape();
  curveVertex(0,  r*2/5);
  curveVertex(0,  r*2/5);
  curveVertex(r*1/10,  r*1/5);
  curveVertex(r*3/10,  0);
  curveVertex(r*3/10,  0);
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(x + r/8, y-r/8);
  beginShape();
  curveVertex(0,  r*2/5);
  curveVertex(0,  r*2/5);
  curveVertex(r*1/10,  r*1/5);
  curveVertex(r*3/10,  0);
  curveVertex(r*3/10,  0);
  endShape();
  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("level_designer.png");
  } else if (key == 'l') {
    mode = LAND;
  } else if (key == 'w') {
    mode = WATER;
  } else if (key == 't') {
    mode = TREASURE;
  } 
  
  if (keyCode == UP) {
    selectY = max((selectY - 1), 0);
  } else if (keyCode == DOWN) {
    selectY = min((selectY + 1), int(dims.y)-1);
  } else if (keyCode == LEFT) {
    selectX = max((selectX - 1), 0);
  } else if (keyCode == RIGHT) {
    selectX = min((selectX + 1), int(dims.x)-1);
  }
  
  if (key == ENTER) {
     map[selectY][selectX] = mode;
  }
  
}
