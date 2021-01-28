var rot; 

function setup() {
  createCanvas(800, 800);
  smooth();
  rot = 0;
}

function draw() {
  background(253); 
  strokeWeight(2.0); 
  stroke(0); 
  
  push(); 
  translate(-50, 0); 
  
  var mx = -mouseX/200.0; //-0.06;
  rot = 0.95*rot + 0.05*(mx); 

  var nLines = 80; 
  for (var i=0; i<nLines; i++) {
    var x = map(i, 0, nLines-1, width/2-250, width/2+250); 
    line(x, 0, x, height);
  }
  
  var tx = 0.598;
  push();
  translate(width*tx, height/2); 
  rotate(rot); 
  for (var i=0; i<nLines; i++) {
    x = map(i, 0, nLines-1, -250, 250); 
    line(x, -height*0.4, x, height*0.4);
  }
  pop();
  pop();
}
