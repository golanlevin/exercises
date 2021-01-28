// Grid with Randomness

void setup() {
  size(800, 800);
  smooth();
  noLoop(); 
}

void draw() {
  background(253); 
  strokeWeight(2);
  stroke(0); 
  noFill(); 
  
  int n = 8;
  float w = width/n;
  
  for (int y=0; y<n; y++) {
    for (int x=0; x<n; x++) {
      float px = x * w; 
      float py = y * w; 
      //the chance of drawing a circle is 5%
      //otherwise, it draws a square
      float chance = random(1); 
      if (chance < 0.1){
        ellipse(px+w/2, py+w/2, w-25, w-25);
      } else {
        rect(px+10, py+10, w-20, w-20);
      }
    }
  }
}

void keyPressed(){
  if (key == 's'){
    saveFrame("../grid_with_randomness.png"); 
  }
}
