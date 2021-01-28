// Simple iteration. 
// Uses introductory "immediate mode"
// With no setup() or draw() functions. 

size(800, 800, FX2D);
background (253); 

fill(229); 
strokeWeight(8); 
stroke(0); 

float y = height * (1.0 - 0.61803398875); 

//draws 7 circles
for (int i=0; i<7; i++) {
  //sets space between circle centers to 50
  float x = 100 + i*100;
  //draws circles of radius 30
  ellipse(x, y, 60, 60);
}

saveFrame("../simple_iteration.png"); 
