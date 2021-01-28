int dice_width = 100;
int num_dice;

//x,y, is top left of die
void drawDie(int x, int y){
  int number = int(random(1,6));
  int d = int(dice_width/7);
  //fill(231,29,54);
  fill(200);
  rect(x,y,dice_width,dice_width, 10);
  
  fill(255);
  if(number == 1){
    ellipse(x+d*3.5, y+d*3.5,d,d);
  }  
  else if(number == 2){
    if(int(random(1)) == 0){
      ellipse(x+d*1.5,y+d*5.5,d,d);
      ellipse(x+d*5.5,y+d*1.5,d,d);
    }
    else{
      ellipse(x+d*1.5,y+d*1.5,d,d);
      ellipse(x+d*5.5,y+d*5.5,d,d);
    }
  }
  else if(number == 3){
    ellipse(x+d*3.5, y+d*3.5,d,d);
    if(int(random(1)) == 0){
      ellipse(x+d*1.5,y+d*5.5,d,d);
      ellipse(x+d*5.5,y+d*1.5,d,d);
    }
    else{
      ellipse(x+d*1.5,y+d*1.5,d,d);
      ellipse(x+d*5.5,y+d*5.5,d,d);
    }
  }
  else if(number == 4){
    ellipse(x+d*1.5,y+d*5.5,d,d);
    ellipse(x+d*5.5,y+d*1.5,d,d);
    ellipse(x+d*1.5,y+d*1.5,d,d);
    ellipse(x+d*5.5,y+d*5.5,d,d);
  }
  else if(number == 5){
    ellipse(x+d*3.5, y+d*3.5,d,d);
    ellipse(x+d*1.5,y+d*5.5,d,d);
    ellipse(x+d*5.5,y+d*1.5,d,d);
    ellipse(x+d*1.5,y+d*1.5,d,d);
    ellipse(x+d*5.5,y+d*5.5,d,d);
  }
  else{
    ellipse(x+d*1.5,y+d*5.5,d,d);
    ellipse(x+d*5.5,y+d*1.5,d,d);
    ellipse(x+d*1.5,y+d*1.5,d,d);
    ellipse(x+d*5.5,y+d*5.5,d,d);
    if(int(random(1))==0){
    ellipse(x+d*3.5,y+d*1.5,d,d);
    ellipse(x+d*3.5,y+d*5.5,d,d);      
    }
    else{
    ellipse(x+d*5.5,y+d*3.5,d,d);
    ellipse(x+d*1.5,y+d*3.5,d,d);  
    }
  }
}

void setup(){
  size(300,300);
  background(255);
  noStroke();
}

boolean overlaps(int x, int y){
  loadPixels();
  color white = color(255);
  if(pixels[x+width*y] != white ||
     pixels[(x+dice_width)+width*y] != white || 
     pixels[x+width*(y+dice_width)] != white || 
     pixels[(x+dice_width)+width*(y+dice_width)] != white){
       return true;}
     return false;
}

void drawDice(){
  background(255);
  for (int i = 0; i < num_dice; i++){

   int x = int(random(width-dice_width));
   int y = int(random(height-dice_width));
   
   while(overlaps(x,y) == true){
     x = int(random(width-dice_width));
     y = int(random(height-dice_width));
   }
   
   drawDie(x, y); 
  }
  
}

void keyPressed() {
  dice_width = 100;
  if (key == '1'){
    num_dice = 1;
  }
    if (key == '2'){
    num_dice = 2;
  }
    if (key == '3'){
    num_dice = 3;
  }
    if (key == '4'){
    num_dice = 4;
  }
    if (key == '5'){
    dice_width = 80;
    num_dice = 5;
  }
    if (key == '6'){
    dice_width = 60;
    num_dice = 6;
  }
  
  drawDice();
}

void draw(){
}
