int dice_width = 266;
int num_dice;

void setup() {
  size(800, 800);
  background(253);
  
  generateRoll('6'); 
}

//-----------------------------------------------
//x,y, is top left of die
void drawDie(int x, int y) {
  
  noStroke();
  ellipseMode(CENTER); 
  int number = int(random(1, 6.999999));
  float d = (dice_width/7.0);
  float diam = dice_width/6.0; 

  fill(200);
  rect(x, y, dice_width, dice_width, 27);

  fill(255);
  if (number == 1) {
    ellipse(x+d*3.5, y+d*3.5, diam, diam);
  } else if (number == 2) {
    if (random(1.0) < 0.5) {
      ellipse(x+d*1.5, y+d*5.5, diam, diam); 
      ellipse(x+d*5.5, y+d*1.5, diam, diam);
    } else {
      ellipse(x+d*1.5, y+d*1.5, diam, diam); 
      ellipse(x+d*5.5, y+d*5.5, diam, diam);
    }
  } else if (number == 3) {
    ellipse(x+d*3.5, y+d*3.5, diam, diam); 
    if (random(1) < 0.5) {
      ellipse(x+d*1.5, y+d*5.5, diam, diam); 
      ellipse(x+d*5.5, y+d*1.5, diam, diam);
    } else {
      ellipse(x+d*1.5, y+d*1.5, diam, diam); 
      ellipse(x+d*5.5, y+d*5.5, diam, diam);
    }
  } else if (number == 4) {
    ellipse(x+d*1.5, y+d*5.5, diam, diam); 
    ellipse(x+d*5.5, y+d*1.5, diam, diam); 
    ellipse(x+d*1.5, y+d*1.5, diam, diam); 
    ellipse(x+d*5.5, y+d*5.5, diam, diam);
  } else if (number == 5) {
    ellipse(x+d*3.5, y+d*3.5, diam, diam); 
    ellipse(x+d*1.5, y+d*5.5, diam, diam); 
    ellipse(x+d*5.5, y+d*1.5, diam, diam); 
    ellipse(x+d*1.5, y+d*1.5, diam, diam); 
    ellipse(x+d*5.5, y+d*5.5, diam, diam);
  } else {
    ellipse(x+d*1.5, y+d*5.5, diam, diam); 
    ellipse(x+d*5.5, y+d*1.5, diam, diam); 
    ellipse(x+d*1.5, y+d*1.5, diam, diam); 
    ellipse(x+d*5.5, y+d*5.5, diam, diam); 
    if (random(1) < 0.5) {
      ellipse(x+d*3.5, y+d*1.5, diam, diam); 
      ellipse(x+d*3.5, y+d*5.5, diam, diam);
    } else {
      ellipse(x+d*5.5, y+d*3.5, diam, diam); 
      ellipse(x+d*1.5, y+d*3.5, diam, diam);
    }
  }
}




//-----------------------------------------------
boolean overlaps(int x, int y) {
  loadPixels();
  color white = color(255);
  if (pixels[x+width*y] != white ||
    pixels[(x+dice_width)+width*y] != white || 
    pixels[x+width*(y+dice_width)] != white || 
    pixels[(x+dice_width)+width*(y+dice_width)] != white) {
    return true;
  }
  return false;
}


//-----------------------------------------------
void drawDice() {
  
  background(255);
  for (int i = 0; i < num_dice; i++) {

    int x = int(random(width-dice_width));
    int y = int(random(height-dice_width));

    while (overlaps(x, y) == true) {
      x = int(random(width-dice_width));
      y = int(random(height-dice_width));
    }

    drawDie(x, y);
  }
}

//-----------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("roll_the_dice_#####.png");
  } else {
    generateRoll(key); 
  }
}

//-----------------------------------------------
void generateRoll(char c){
  if (c == '1') {
    dice_width = 266;
    num_dice = 1;
  }
  if (c == '2') {
    dice_width = 240;
    num_dice = 2;
  }
  if (c == '3') {
    dice_width = 220;
    num_dice = 3;
  }
  if (c == '4') {
    dice_width = 200;
    num_dice = 4;
  }
  if (c == '5') {
    dice_width = 180;
    num_dice = 5;
  }
  if (c == '6') {
    dice_width = 160;
    num_dice = 6;
  }

  drawDice();
}




void draw() {
}
