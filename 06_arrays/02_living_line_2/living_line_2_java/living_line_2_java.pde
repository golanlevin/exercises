//Exercises: Arrays
//Living Line 2

float xPos[]= new float[100];
float yPos[]= new float[100];

int p=0;
int step = 1;
PImage cursorImg;
boolean bMoved = false;
boolean bDoSave = false;

void setup() {
  size(800, 800);
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
  p = 50;
}

void draw() {
  background(253);

  noFill(); 
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(ROUND); 
  beginShape(); 
  for (int i=0; i<100; i++) { 
    vertex(xPos[i], yPos[i]);
  }
  endShape(); 

  if (bMoved) {
    for (int i=0; i<99; i++) { //only change arrays if mouse moved
      line(xPos[i], yPos[i], xPos[i+1], yPos[i+1]); 
      xPos[i]=xPos[i+1]; //move each value along the array
      yPos[i]=yPos[i+1]; //move each value along the array
    }
    xPos[99]=mouseX; //add new value to the end of the array
    yPos[99]=mouseY; //add new value to the end of the array
    bMoved = false;

    // smooth the gesture.
    for (int j=1; j<99; j++) { 
      float ix = xPos[j-1];
      float jx = xPos[j  ];
      float kx = xPos[j+1];

      float iy = yPos[j-1];
      float jy = yPos[j  ];
      float ky = yPos[j+1];

      xPos[j] = (ix + jx + kx)/3.0;
      yPos[j] = (iy + jy + ky)/3.0;
    }
  }

  // draw ellipse
  p += step;
  if (p == 0) {
    step = 1;
    p = 1;
  }
  if (p == 99) {
    step = -1;
    p = 98;
  }
  
  stroke(0); 
  strokeWeight(8); 
  fill(255, 200, 200);
  pushMatrix();
  translate(0, 0, 10);
  ellipse(xPos[p], yPos[p], 60, 60);
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
  popMatrix(); 
}

void mouseMoved() {
  bMoved = true;
}

void keyPressed() {
  if (key == ' ') {
    bDoSave = true;
    saveFrame("livingline2_####.png");
    bDoSave = false;
  }
}
