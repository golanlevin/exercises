var sourceImg;
var cursorImg; 
var myFont; 

//------------------------------------
function setup() {
  createCanvas(800, 800);
  sourceImg = loadImage("data/monet_haystack.jpg"); 
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png");
  myFont = textFont("Helvetica-Bold", 60);
}

//------------------------------------
function draw() {
  background(253); 
  textFont(myFont, 60); 

  image(sourceImg, 0, 0, 800, 629); 
  var col = get(mouseX, mouseY); 
  var colr = red(col); 
  var colg = green(col); 
  var colb = blue(col); 

  fill(col); 
  noStroke(); 
  var m = 24; 
  var eh = (height-629)-2*m;
  rect(m, 629+m, eh, eh, m); 

  ellipseMode(CENTER); 
  noStroke(); 
  var ew = (width - eh - 2*m)/3 - m;
  fill(colr, 0, 0); 
  ellipse(m+eh+m+ew/2, 629+m+ eh/2, ew, eh); 
  fill(0, colg, 0); 
  ellipse(m+eh+m+ew+m+ew/2, 629+m+ eh/2, ew, eh); 
  fill(0, 0, colb); 
  ellipse(m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2, ew, eh); 

  fill(255); 
  textAlign(CENTER, CENTER); 
  text(colr, m+eh+m+ew/2, 629+m+ eh/2 - 4); 
  text(colg, m+eh+m+ew+m+ew/2, 629+m+ eh/2 - 4); 
  text(colb, m+eh+m+ew+m+ew+m+ew/2, 629+m+ eh/2 - 4); 

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}
