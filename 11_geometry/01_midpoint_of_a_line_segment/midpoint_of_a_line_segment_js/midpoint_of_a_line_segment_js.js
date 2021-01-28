var A; 
var B; 
var myFont;

function setup() {
  createCanvas(800, 800); 
  myFont = textFont("Helvetica-bold", 72); 
  
  A = createVector(width*0.22, height*0.65);
  B = createVector(width*0.75, height*0.3);
}

function draw() {
  background(253); 
  // B = createVector(mouseX, mouseY, 0);

  var dx = B.x-A.x;
  var dy = B.y-A.y;
  var dh = sqrt(dx*dx + dy*dy); 

  var midx = A.x+dx/2;
  var midy = A.y+dy/2;
  
  stroke(0); 
  strokeWeight(8);
  line(A.x, A.y, B.x, B.y); 
  
  // Draw end points and midpoint
  fill(0); 
  noStroke(); 
  ellipseMode(CENTER); 
  ellipse(A.x, A.y, 24, 24); 
  ellipse(B.x, B.y, 24, 24); 
  ellipse(midx, midy, 32, 32); 

  // Draw one-third point
  stroke(0); 
  strokeWeight(8);
  fill(0, 255, 0);
  var x3 = lerp(A.x, B.x, 1.0/3.0); 
  var y3 = lerp(A.y, B.y, 1.0/3.0); 
  ellipse(x3, y3, 32, 32);  
  

  // Draw text labels
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  var dist = 70;
  text("A", A.x - dist*dx/dh, A.y - dist*dy/dh); 
  text("B", B.x + dist*dx/dh, B.y + dist*dy/dh);
}



function mousePressed() {
  reset();
}

function reset() {
  A = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0); 
  B = createVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9), 0);
}
