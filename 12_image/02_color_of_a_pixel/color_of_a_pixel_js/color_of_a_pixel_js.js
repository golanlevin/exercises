var myImage; 
var cursorImg; 

function setup(){
  createCanvas(800,800); 
  myImage = loadImage("data/3302-800px.png"); 
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); 
}

function draw(){
  background(253); 
  image(myImage, 20,80); 
  
  
  var cx = 600; 
  var cy = 200; 
  var cd = 200; 
  var col = get(mouseX, mouseY);
  
  noFill();  
  stroke(0); 
  strokeWeight(8); 
  strokeJoin(MITER); 
  strokeCap(SQUARE); 
  beginShape();
  vertex(mouseX, mouseY+4);
  vertex(cx, mouseY+4); 
  vertex(cx, cy); 
  endShape(); 
  

  fill(col); 
  ellipse(cx, cy, cd, cd); 
  image(cursorImg, mouseX, mouseY, 15*6, 21*6); 
}  

function keyPressed(){
  if (key == ' '){
    save("color_of_a_pixel.png"); 
  }
}
