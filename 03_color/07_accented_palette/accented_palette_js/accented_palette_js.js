function setup() {
  createCanvas(800, 800); 
  
  // Complementary is a color scheme using one base color and its complement, 
  // the color on the exact opposite side of the color wheel. 
  // The base color is main and dominant, while the complementary color is used only as an accent. 
  // http://paletton.com/wiki/index.php?title=Complementary_color_scheme
  
  colorMode(HSB, 360, 100, 100);
}

function draw() {
  
  background(0, 0, 100);
  
  var hA = map(mouseX, 0, width, 0, 360);
  var sA = 100;
  var bA = 90; 
  var c1 = color(hA, sA, bA);

  var hB = (hA + 180.0)%360.0;
  var sB = sA; 
  var bB = bA; 
  var c2 = color(hB, sB, bB);

  noStroke();

  fill(c1);
  rect(0, 0, width*0.75, 120);
  fill(c2);
  rect(width*0.75, 0, width*0.25, 120);
  
  for (var xx = 0; xx < width*0.75; xx += width*0.15) {
    var b = map(xx, 0, width*0.75, 100, 0);
    fill(hA, sA, b);
    rect(xx, 120, width*0.15, 40); 
  }
  
  for (xx = width*0.75; xx < width; xx += width*0.05) {
    var b = map(xx, width*0.75, width, 100, 0);
    fill(hB, sB, b);
    rect(xx, 120, width*0.05, 40); 
  }

  var nx = 20; 
  var ny = 16; 
  var rw = width/nx; 
  var rh = height/ny;
  for (var y=0; y<ny; y++) {
    for (var x=0; x<nx; x++) {
      var rx = map(x, 0, nx, 0, width); 
      var ry = map(y, 0, ny, 4*rh, height); 
      var pick = random(100);
      var s = random(50, 100);
      var b = random(50, 100);
      if (pick < 75) {
        fill(hA, s, b);
      } else {
        fill(hB, s, b);
      }
      rect(rx, ry, rw, rh);
    }
  }

  noLoop();
}

function mouseMoved() {
  loop();
}
