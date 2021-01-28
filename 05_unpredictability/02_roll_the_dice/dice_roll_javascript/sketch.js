var dice_width = 100;
var num_dice;

//x,y, is top left of die
function drawDie(x, y){
  var number = int(random(1,6));
  var d = int(dice_width/7);
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

function setup(){
  createCanvas(300,300);
  background(255);
  noStroke();
}

function overlaps(x, y){
  loadPixels();
  var white = 255;
  if(pixels[x+width*y] != white ||
     pixels[(x+dice_width)+width*y] != white || 
     pixels[x+width*(y+dice_width)] != white || 
     pixels[(x+dice_width)+width*(y+dice_width)] != white){
       return true;}
     return false;
}

function drawDice(){
  background(255);
  for (var i = 0; i < num_dice; i++){

   var x = int(random(width-dice_width));
   var y = int(random(height-dice_width));
   
   while(overlaps(x,y) == true){
     x = int(random(width-dice_width));
     y = int(random(height-dice_width));
   }
   drawDie(x, y); 
  }
  
}

function keyPressed() {
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

function draw(){
}