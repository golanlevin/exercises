//Exercises: Arrays
//Living Line 1

float xPos[]= new float[100];
float yPos[]= new float[100];

int p=0;
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

      xPos[j] = (ix + 14*jx + kx)/16.0;
      yPos[j] = (iy + 14*jy + ky)/16.0;
    }
    
  }

  // add noise to the gesture.
  // add more noise to older points, for fun.
  for (int j=0; j<99; j++) { 
    xPos[j] += 0.2*(99-j)*random(-1, 1);
    yPos[j] += 0.2*(99-j)*random(-1, 1);
  }



  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

void mouseMoved() {
  bMoved = true;
}

void keyPressed() {
  if (key == ' ') {
    bDoSave = true;
    saveFrame("livingline3_####.png");
    bDoSave = false;
  }
}
