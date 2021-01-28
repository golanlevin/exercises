var colorWheelImg; 
var cursorImg; 

function setup() {
  createCanvas(800, 800); 
  colorWheelImg = loadImage("data/color_wheel.png"); 
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png");
}

function draw() {
  background(253);
  image(colorWheelImg, 0, 0); 

  colorMode(HSB, 100);
  var radius = 320;
  var mx = mouseX - width/2; 
  var my = mouseY - height/2; 
  var mr = sqrt(mx*mx + my*my); 
  var ma = (TWO_PI + atan2(my, mx))%TWO_PI; 
  var mh = map(ma, 0, TWO_PI, 0, 100);
  var ms = map(mr, 0, radius, 0, 100);
  
  var ma1 = (ma + radians(180-30))%TWO_PI; 
  var ma2 = (ma + radians(180+30))%TWO_PI; 
  
  drawColorEllipse( radius, ma, mr);
  drawColorEllipse( radius, ma1, mr);
  drawColorEllipse( radius, ma2, mr);

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


//---------------------------------------------------
function drawColorEllipse(radius, ma, mr){
  
  var mh = map(ma, 0, TWO_PI, 0, 100);
  var ms = map(mr, 0, radius, 0, 100);
  var mx = width/2  + mr * cos(ma); 
  var my = height/2 + mr * sin(ma); 
  
  noStroke();
  fill(0, 0, 0, 10); 
  var er = radius*0.4;
  ellipse(mx+8, my+8, er+4, er+4); 
  
  stroke(0); 
  strokeWeight(8); 
  ellipseMode(CENTER);
  fill(mh, ms, 100);
  ellipse(mx, my, er, er); 
}
