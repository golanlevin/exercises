function setup() {
  createCanvas(800, 800);
   
  background(253);
  
  push();
  translate(width/2, height/2);
 
  var radius = 320;
  colorMode(HSB, 100);
  ellipseMode(CENTER);
  noStroke();
  
  for (var t = 0; t<720; t++){
    var a = map(t, 0,720, 0, TWO_PI); 
    
    for (var r = 0; r < radius; r += 1) {
      var h = map(a, 0, TWO_PI, 0, 100);
      var s = map(r, 0, radius, 0, 100);
      fill(h, s, 100);
      var x = r*cos(a);
      var y = r*sin(a);
      ellipse(x, y, 3, 3);
    }
  }
  pop();
  noLoop();

  
}
