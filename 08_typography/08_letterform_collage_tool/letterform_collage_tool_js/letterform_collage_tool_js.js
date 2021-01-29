// Letter collage 

var myFont; 
var whichColor = 0; 
var mostRecentKey = ' '; 
var pg; 

function setup() {
  createCanvas(800, 800); 
  myFont = textFont("Gotham-Black", 256);
  textAlign(CENTER, CENTER); 

  pg = createGraphics(800, 800); 
  pg.textFont("Gotham-Black", 256); 
  pg.textAlign(CENTER, CENTER); 
  pg.background(253);
}

//=====================================
function draw() {
  image(pg, 0, 0); 

  fill (whichColor*255, 64); 
  translate(mouseX, mouseY); 
  text(key, 0, 0);
}

//=====================================
function mouseReleased() {
  pg.fill(whichColor*255); 
  //pg.translate(mouseX, mouseY); 
  pg.text(key, mouseX, mouseY);
}

//=====================================
function keyTyped() {
  if (key == mostRecentKey){
    whichColor = 1-whichColor;
  }
  if (key == ' ') {
    pg.background(whichColor * 255);
  } else if (key == 's'){
        saveFrames('letter_collage', 'png', 1, 1);
  }
  mostRecentKey = key; 
}
