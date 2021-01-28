// Grid with Randomness

function setup() {
  createCanvas(800, 800);
  smooth();
  noLoop(); 
}

function draw() {
  background(253); 
  strokeWeight(2);
  stroke(0); 
  noFill(); 
  
  var n = 8;
  var w = width/n;
  
  for (var y=0; y<n; y++) {
    for (var x=0; x<n; x++) {
      var px = x * w; 
      var py = y * w; 
      
      //the chance of drawing a circle is 5%
      //otherwise, it draws a square
      var chance = random(1); 
      if (chance < 0.05){
        ellipse(px+w/2, py+w/2, w-20, w-20);
      } else {
        rect(px+10, py+10, w-20, w-20);
      }
    }
  }
}
