// Example 10-10: The raindrop catching game

class Catcher {
  float r;    // radius
  color col;  // color
  float x, y; // location

  Catcher(float tempR) {
    r = tempR;
    col = color(50, 10, 10, 150);
    x = 0;
    y = 0;
  }

  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void display1(){
    stroke(0); 
    strokeWeight(8); 
    fill(255, 200,200); 
    ellipse(x, y, r, r/2); //, PI, TWO_PI); 
  }
  
  void display2(){
    stroke(0); 
    strokeWeight(8); 
    fill(255, 200,200); 
    beginShape();
    int n = 24; 
    for (int i=0; i<n; i++){
      float a = map(i, 0, n-1, 0, PI); 
      float px = x + r/2*cos(a); 
      float py = y + r/4*sin(a); 
      vertex(px, py); 
    }
    vertex(x - r/2, y); 
    vertex(x - r/2, y+80); 
    
    for (int i=0; i<n; i++){
      float a = map(i, 0, n-1, PI, 0); 
      float px = x + r/2*cos(a); 
      float py = y + r/4*sin(a) + 80; 
      vertex(px, py); 
    }
    
    
    vertex(x + r/2, y+80); 
    vertex(x + r/2, y);
    
    endShape(); 
  }
  
  
  
  void display() {
    stroke(0);
    fill(col);
    ellipse(x, y, r*2, r*2);
  }

  // A function that returns true or false based on
  // if the catcher intersects a raindrop
  boolean intersect(Drop d) {
    // Calculate distance
    float dx = x - d.x;
    float dy = y - (d.y - 80);
    float distance = sqrt(dx*dx + dy*dy); 

    // Compare distance to sum of radii
    if (distance < ((r/2) + d.r)) { 
      return true;
    } else {
      return false;
    }
  }
}
