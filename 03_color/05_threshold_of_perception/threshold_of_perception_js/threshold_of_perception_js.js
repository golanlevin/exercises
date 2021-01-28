function setup() {
  createCanvas(800, 800);
}

function draw() {
  noStroke();
  
  fill(60, 130, 235);
  rect(0, 0, width, height);
  fill(65, 135, 240);
  ellipse(width/2, height/2, width*0.6, height*0.6);
}
