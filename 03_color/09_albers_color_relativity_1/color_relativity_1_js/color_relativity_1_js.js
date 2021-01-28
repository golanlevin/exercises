//Exercises: Color
//Color relativity

function setup() {
  createCanvas(800, 800);
  noStroke();
}

function draw() {
  // Make 3 colors look like 4. 

  rectMode(CORNER); 
  fill(148, 91,35);      //// Color 2
  rect(0, 0, width/2, height);
   
  
  fill(67, 147, 151);    //// Color 1
  rect(width/2, 0, width/2, height); 


  fill(170, 102, 22);  //// Color 3
  ellipseMode(CENTER); 
  ellipse(1*width/4, height/2, width/6, width/6);
  ellipse(3*width/4, height/2, width/6, width/6);
}
