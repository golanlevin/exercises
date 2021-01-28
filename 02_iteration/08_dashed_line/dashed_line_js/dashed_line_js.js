function setup() {
  createCanvas(800, 800);
  smooth(); 
}

function draw() {
  background(253); 

  //these x and y values represent the line from the point to your cursor
  var x0 = width * 0.75;
  var y0 = height * 0.25;
  var x1 = mouseX;
  var y1 = mouseY; 

  var dashLength = 50.0; 
  var lineLength = dist(x0, y0, x1, y1); 
  var nDashesf = (lineLength / dashLength);

  noStroke();
  fill(0);
  ellipse(x0, y0, 20, 20); 

  //splits the calculated line into multiple lines, making dashes
  for (var i=0; i<nDashesf; i++) {
    var percentA = map(i+0.0, 0, nDashesf, 0, 1);
    var percentB = map(min(i+0.6, nDashesf), 0, nDashesf, 0, 1);

    var dashXa = map(percentA, 0, 1, x0, x1); 
    var dashYa = map(percentA, 0, 1, y0, y1);
    var dashXb = map(percentB, 0, 1, x0, x1); 
    var dashYb = map(percentB, 0, 1, y0, y1);

    stroke(0);
    strokeWeight(8);
    line (dashXa, dashYa, dashXb, dashYb);
  }
}
