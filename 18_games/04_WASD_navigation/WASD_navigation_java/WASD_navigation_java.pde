int mode;

final int PAUSE_MODE = 0;
final int UP_MODE = 1;
final int DOWN_MODE = 2;
final int LEFT_MODE = 3;
final int RIGHT_MODE = 4;

float bodysize;
float speed;

float x;
float y;

void setup() {
  size(800, 800);
  
  bodysize = 200;
  speed = 10;
  
  x = width/2;
  y = height/2;

  stroke(0);
  strokeWeight(8);

  
}

void draw() {
  background(253);

  int f = floor((millis()%1000)/1000.0 * 4);
  if (!keyPressed) {
    f = 0;
  }
  switch(mode) {
    case UP_MODE:
      drawUp(f);
      break;
    case DOWN_MODE:
      drawDown(f);      
      break;
    case LEFT_MODE:
      drawLeft(f);      
      break;
    case RIGHT_MODE:
      drawRight(f);      
      break;
    default:
      drawLeft(f);
      break;
  }

}

void drawLeft (int frame) {
  
  // draw legs
  strokeWeight(8);
  stroke(0);
  if (frame == 0) {
    line(x, y, x-bodysize/8, y+bodysize);
    line(x-bodysize/8, y+bodysize, x-bodysize/8-bodysize/4, y+bodysize-bodysize/12);
    line(x, y, x+bodysize/8, y+bodysize);
    line(x+bodysize/8, y+bodysize, x+bodysize/8-bodysize/4, y+bodysize+bodysize/12);
  } else {
    line(x, y, x-bodysize/2, y+bodysize);
    line(x-bodysize/2, y+bodysize, x-bodysize/2-bodysize/4, y+bodysize-bodysize/8);
    line(x, y, x+bodysize/2, y+bodysize);
    line(x+bodysize/2, y+bodysize, x+bodysize/2-bodysize/4, y+bodysize+bodysize/8);
  }
  
  // draw body
  fill(255, 200, 200);
  rectMode(CENTER);
  rect(x, y, bodysize, bodysize);
  arc(x, y-bodysize/2+5, bodysize, bodysize, PI, 2*PI, OPEN);
  
  // draw eyes
  
  ellipseMode(CENTER);
  fill(255);
  ellipse(x-bodysize/4, y-bodysize/2, bodysize/4, bodysize/4);
  fill(0);
  ellipse(x-bodysize/4-bodysize/8/2, y-bodysize/2, bodysize/8, bodysize/8);

}

void drawRight (int frame) {
  
  // draw legs
  stroke(0);
  if (frame == 0 || frame == 2) {
    line(x, y, x-bodysize/2, y+bodysize);
    line(x-bodysize/2, y+bodysize, x-bodysize/2+bodysize/4, y+bodysize+bodysize/8);
    line(x, y, x+bodysize/2, y+bodysize);
    line(x+bodysize/2, y+bodysize, x+bodysize/2+bodysize/4, y+bodysize-bodysize/8);
  } else {
    line(x, y, x-bodysize/8, y+bodysize);
    line(x-bodysize/8, y+bodysize, x-bodysize/8+bodysize/4, y+bodysize+bodysize/12);
    line(x, y, x+bodysize/8, y+bodysize);
    line(x+bodysize/8, y+bodysize, x+bodysize/8+bodysize/4, y+bodysize-bodysize/12);
  } 
  
  // draw body

  fill(255, 200, 200);
  rectMode(CENTER);
  rect(x, y, bodysize, bodysize);
  arc(x, y-bodysize/2+5, bodysize, bodysize, PI, 2*PI, OPEN);
  
  // draw eyes
  ellipseMode(CENTER);
  fill(255);
  ellipse(x+bodysize/4, y-bodysize/2, bodysize/4, bodysize/4);
  fill(0);
  ellipse(x+bodysize/4+bodysize/8/2, y-bodysize/2, bodysize/8, bodysize/8);

}

void drawDown(int frame) {
  // draw legs
  stroke(0);
  strokeWeight(8);
  if (frame == 1) {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize);
    line(x-bodysize/4, y+bodysize, x-bodysize/4-bodysize/8, y+bodysize+bodysize/4);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize*2/3);
    line(x+bodysize/4, y+bodysize*2/3, x+bodysize/4+bodysize/8, y+bodysize*2/3+bodysize/4);
  } else if (frame == 2) {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize*2/3);
    line(x-bodysize/4, y+bodysize*2/3, x-bodysize/4-bodysize/8, y+bodysize*2/3+bodysize/4);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize*2/3);
    line(x+bodysize/4, y+bodysize*2/3, x+bodysize/4+bodysize/8, y+bodysize*2/3+bodysize/4);
  } else if (frame == 3) {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize*2/3);
    line(x-bodysize/4, y+bodysize*2/3, x-bodysize/4-bodysize/8, y+bodysize*2/3+bodysize/4);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize);
    line(x+bodysize/4, y+bodysize, x+bodysize/4+bodysize/8, y+bodysize+bodysize/4);
  } else {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize*2/3);
    line(x-bodysize/4, y+bodysize*2/3, x-bodysize/4-bodysize/8, y+bodysize*2/3+bodysize/4);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize*2/3);
    line(x+bodysize/4, y+bodysize*2/3, x+bodysize/4+bodysize/8, y+bodysize*2/3+bodysize/4);
  }
  
  // draw body

  fill(255, 200, 200);
  rectMode(CENTER);
  rect(x, y, bodysize, bodysize);
  arc(x, y-bodysize/2+5, bodysize, bodysize, PI, 2*PI, OPEN);
  
  // draw eyes
  ellipseMode(CENTER);
  fill(255);
  ellipse(x-bodysize/4, y-bodysize/2, bodysize/4, bodysize/4);
  fill(0);
  ellipse(x-bodysize/4, y-bodysize/2+bodysize/8/2, bodysize/8, bodysize/8);
  
  fill(255);
  ellipse(x+bodysize/4, y-bodysize/2, bodysize/4, bodysize/4);
  fill(0);
  ellipse(x+bodysize/4, y-bodysize/2+bodysize/8/2, bodysize/8, bodysize/8);

}

void drawUp(int frame) {
  // draw legs
  stroke(0);
  strokeWeight(8);
  if (frame == 1) {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize);
    line(x-bodysize/4, y+bodysize, x-bodysize/4-bodysize/8, y+bodysize-bodysize/10);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize*3/4);
    line(x+bodysize/4, y+bodysize*3/4, x+bodysize/4+bodysize/8, y+bodysize*3/4-bodysize/10);
  } else if (frame == 3) {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize*3/4);
    line(x-bodysize/4, y+bodysize*3/4, x-bodysize/4-bodysize/8, y+bodysize*3/4-bodysize/10);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize);
    line(x+bodysize/4, y+bodysize, x+bodysize/4+bodysize/8, y+bodysize-bodysize/10);
  } else {
    line(x-bodysize/4, y, x-bodysize/4, y+bodysize*3/4);
    line(x-bodysize/4, y+bodysize*3/4, x-bodysize/4-bodysize/8, y+bodysize*3/4-bodysize/10);
    line(x+bodysize/4, y, x+bodysize/4, y+bodysize*3/4);
    line(x+bodysize/4, y+bodysize*3/4, x+bodysize/4+bodysize/8, y+bodysize*3/4-bodysize/10);
  }
  
  // draw body

  fill(255, 200, 200);
  rectMode(CENTER);
  rect(x, y, bodysize, bodysize);
  arc(x, y-bodysize/2+5, bodysize, bodysize, PI, 2*PI, OPEN);
}


void keyPressed() {
  switch(keyCode) {
    case UP:
      mode = UP_MODE;
      y = max(y-speed, 0);
      break;
    case DOWN:
      mode = DOWN_MODE;
      y = min(y+speed, height);
      break;
    case LEFT:
      mode = LEFT_MODE;
      x = max(x-speed, 0);
      break;
    case RIGHT:
      mode = RIGHT_MODE;
      x = min(x+speed, width);
      break;
    case 87: // w = up
      mode = UP_MODE;
      y = max(y-speed, 0);
      break;
    case 83: // s = down
      mode = DOWN_MODE;
      y = min(y+speed, height);
      break;
    case 65: // a = left
      mode = LEFT_MODE;
      x = max(x-speed, 0);
      break;
    case 68: // d = right
      mode = RIGHT_MODE;
      x = min(x+speed, width);
      break;
    default:
      break;
  }
  if (key == ' ') {
    saveFrame("wasd_navigation.png");
  }
}
