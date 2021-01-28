void setup(){
  size(800, 800); 
  noiseSeed(5); 
  noiseDetail(5, 0.5);
}

void draw(){
  
  
  float zoom = 200.0; 
  color land = color(245, 222, 179); // Wheat
  color water = color(32, 178, 170); // LightSeaGreen
  float thresh = (float) mouseX / width; 
  
  for (int y=0; y<height; y++){
    for (int x=0; x<width; x++){
      float n = noise(x/zoom, y/zoom); 
      
      if (n < thresh){
        set(x, y, water); 
      } else {
        set(x, y, land); 
      }
    }
  }
}


void keyPressed(){
  if (key == ' '){
    noiseSeed(millis()); 
  }
  if (key == 's'){
    saveFrame("imaginary_islands_#####.png"); 
  }
}
