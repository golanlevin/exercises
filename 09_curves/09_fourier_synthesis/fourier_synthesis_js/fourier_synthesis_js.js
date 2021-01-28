function setup() {
  createCanvas(800, 800);
  background(253);
  
  var L = width/4;
  var h = 150;
  
  push(); 
  translate(0, height/2); 
  
  stroke(0); 
  strokeJoin(ROUND); 
  strokeWeight(8);
  beginShape();
  var ox = 30; 
  for (var x = (0-ox); x < (width+ox); x++) {
    var y = 0;
    for (var n = 1; n < 8; n += 2) {
      y += h*4.0/PI*1.0/n * sin(n*PI*(x-2*L)/L * 0.75);
    }
    vertex(x, y);
  }
  endShape();
  
  stroke(0); 
  strokeWeight(2); 
  line(0,0, width, 0); 
  
  pop(); 
}
