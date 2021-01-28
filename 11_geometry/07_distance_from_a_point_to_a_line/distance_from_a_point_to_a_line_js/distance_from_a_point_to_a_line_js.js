var cursorImg;
var myFont;
var P1; 
var P2; 
var P3; 

function setup() {
  createCanvas(800, 800);
  cursorImg = loadImage("data/cursor_with_shadow_15x21.png"); 
  myFont = textFont("Helvetica-bold", 60); 
  textFont(myFont, 60);
  
  P1 = createVector(240, 175); //190, 210);
  P2 = createVector(170, 380); //270, 420);
  P3 = createVector();
}

function draw() {
  background(253); 
  P3.set(mouseX, mouseY); 

  fill(0);
  stroke(0); 
  strokeWeight(8); 
  textAlign(CENTER, CENTER); 

  line(P1.x, P1.y, P2.x, P2.y); 
  ellipse(P1.x, P1.y, 24, 24); 
  ellipse(P2.x, P2.y, 24, 24); 

  // Place text labels at the end vertices
  var dx21 = P2.x-P1.x; 
  var dy21 = P2.y-P1.y; 
  var dh21 = sqrt(dx21*dx21 + dy21*dy21);
  fill(0);
  noStroke();
  var offset = 75; 
  text("P1", P1.x-offset*dx21/dh21, P1.y-offset*dy21/dh21);
  text("P2", P2.x+offset*dx21/dh21, P2.y+offset*dy21/dh21);

  // http://paulbourke.net/geometry/pointlineplane/
  var numer = ((P3.x-P1.x)*(P2.x-P1.x) + (P3.y-P1.y)*(P2.y-P1.y));
  var denom = ((P2.x-P1.x)*(P2.x-P1.x) + (P2.y-P1.y)*(P2.y-P1.y));
  var u = numer / denom; 
  
  if ((u >= 0) && (u <=1)) {
    var px = P1.x + u*(P2.x - P1.x);
    var py = P1.y + u*(P2.y - P1.y);
    
    stroke(0);
    strokeWeight(8); 
    
    line(px, py, P3.x, P3.y); 
    fill(0);
    ellipse(px, py, 24, 24);
    fill(0, 255, 0);
    ellipse(P3.x, P3.y, 32, 32); 
    fill(0);
    noStroke();
    text("P3", P3.x-offset*dx21/dh21, P3.y-offset*dy21/dh21);
    
    var len = sqrt(sq(P3.x-px)+sq(P3.y-py)); 
    var lenStr = "Distance from \nP3 to Line: " + nf(len, 1, 1); 
    
    noStroke();
    text(lenStr, width*0.5, height*0.80); 
  }

  // Draw the cursor image
  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}


function mousePressed() {
  // Generate two new random locations for points A and B. 
  P1.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8)); 
  P2.set(random(width*0.2, width*0.8), random(height*0.2, height*0.8));
}
