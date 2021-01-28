
void setup() {
  size(800, 800); 
  background(253); 
  smooth(); 
  reset();
}

//-------------------------------------------
void draw() {
  noStroke(); 
  fill(253, 2); 
  rect(0,0, width+1, height+1); 

  stroke(0); 
  strokeWeight(8);
  fill(255); 

  float nx = noise(frameCount/240.0 + 19.999);  
  float ny = noise(frameCount/240.0 + 12.345);
  float nd = noise(frameCount/80.0 + 23.456);
  
  float px = map(nx, 0,1, -100, width+100);
  float py = map(ny, 0,1, -100, height+100);
  float pd = map(nd, 0,1, 40,120);  
  
  ellipse(px, py, pd, pd);
}

//-------------------------------------------
void keyPressed() {
  if (key == 'R') {
    reset();
  } else if (key == ' ') {
    saveFrame("animation_with_noise_#####.png");
    background(253);
  }
}

//-------------------------------------------
void reset() {
  background(253);
}
