// Exercises: Array
// Plant the Flag

// A bumpy "landscape" or terrain, 
// consisting of an array of height values, 
// has been provided to you. 
// Write code which searches through this array, 
// and draws "flags" on the peaks (i.e. local maxima).

float terrain[];

void placeFlagsOnTerrain() {
  // PLACE YOUR CODE HERE TO DETECT HILLS

  for (int i=2; i<(width-2); i++) {
    float yZ = terrain[i - 2]; 
    float yA = terrain[i - 1]; 
    float yB = terrain[i + 0];
    float yC = terrain[i + 1];
    float yD = terrain[i + 2];

    if (
      (yZ > yB) && 
      (yA > yB) && 
      (yC > yB) && 
      (yD > yB)) { 
      drawFlag(i, yB); // We found a peak... draw a flag!
    }
  }
}

void drawFlag (float flagx, float flagy) {
  // For example...
  stroke (0); 
  strokeWeight(2.0); 
  line(flagx, flagy, flagx, flagy - 160);
  rect(flagx, flagy-160, 66, 40);
}

//----------------------------------------------------------------------
// There should be no reason for you to modify any code below this line: 
void setup() {
  size(800, 800);
  terrain = new float[width];
}

void draw() {
  
  background(253); 
  
  color skyColor = color(200,230,255); 
  for (int y=0; y<height; y++){
    float t = map(y, 0, height, 0, 1);
    t = pow(t, 0.25); 
    float alpha = map(t, 0,1, 255, 0); 
    stroke(200,230,255, alpha);
    line(0,y, width, y); 
  }
  
  calculateTerrain();
  renderTerrain(); 
  placeFlagsOnTerrain();
}

void calculateTerrain() {
  noiseDetail(2, 0.1); 
  noiseSeed(12345); 
  for (int i=0; i<width; i++) {
    float val = noise(i/100.0 + frameCount/50.0);
    float y = map(val, 0, 1, height*0.25, height*0.80); 
    terrain[i] = y;
  }
}

void renderTerrain() {
  // stroke(10, 90, 10); 
  stroke(0); 
  for (int i=0; i<width; i++) {
    float y = terrain[i]; 
    line (i, height, i, y);
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("plant_the_flag.png");
  }
}
