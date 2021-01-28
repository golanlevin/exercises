function setup() {
  createCanvas(800, 800);
  background(253);
  strokeWeight(8); 
  stroke(0); 
  smooth();
  
  //iterativly draws lines, changing the angle and startpoint, but keeping the endpoint
  //this creates a perspective that recedes into the distance
  for (var i=0-100; i<=width+100; i=i+1) {
    var xTop = width/2 + i*15; 
    var xBot = width/2 + i*90; 
    line (xTop, -1, xBot, height); 
  }
}
