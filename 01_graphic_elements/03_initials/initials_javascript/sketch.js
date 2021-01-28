//Drawing the initials 'TB'

function setup(){
  createCanvas(300,300);
  background(0);
  smooth();
  stroke(255);
  strokeWeight(4);
  
  //draws trunk of the 'T'
  line(width/4+20, 120,width/4+20,240);
  //drawing a semicircle for the top of the 'T'
  noStroke();
  arc(width/4+20, 110, 120, 120, PI, TWO_PI, OPEN);
  
  //draws the backline on the 'B'
  stroke(255);
  line(3*width/4-40, 50,3*width/4-40,240);
  
  //top semicircle of the 'B'
  noStroke();
  arc(3*width/4-30, 100, 100, 100, -1*HALF_PI, HALF_PI, OPEN);
  //lower semicircle of 'B'
  arc(3*width/4-30, 190, 100, 100, -1*HALF_PI, HALF_PI, OPEN);
}