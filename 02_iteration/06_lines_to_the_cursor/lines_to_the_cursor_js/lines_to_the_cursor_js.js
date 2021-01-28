function setup() {
  createCanvas(800, 800); 
  smooth();
}

function draw() {
  background (253); 

  strokeWeight (8);
  stroke(0); 

  var nLines = 10;
  var margin = 100;
  //draws n lines from equidistant starting points to the cursor location 
  for (var i=1; i<=nLines; i++) {
    var x0 = map(i, 1,nLines, margin, width-margin); 
    var y0 = margin; 
    line(x0, y0, mouseX, mouseY);
  }
}
