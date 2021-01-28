// Receding Horizon
// Iteration exercise 
// Java solution

size(800, 800);
background(253);
strokeWeight(3); 
stroke(0); 
smooth();

//iterativly draws lines, changing the angle and startpoint, but keeping the endpoint
//this creates a perspective that recedes into the distance
for (int i=0-100; i<=width+100; i=i+1) {
  float xTop = width/2 + i*10; 
  float xBot = width/2 + i*55; 
  line (xTop, -1, xBot, height); 
}

save("../receding_horizon.png");
