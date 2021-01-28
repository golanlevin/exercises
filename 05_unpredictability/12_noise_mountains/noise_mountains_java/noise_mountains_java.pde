void setup(){
  size(800, 800); 
  noiseSeed(5); 
  noiseDetail(5, 0.5);
}

void draw(){
  
  background(253); 
  
  color skyColor = color(200,230,255); 
  for (int y=0; y<height; y++){
    float t = map(y, 0, height, 0, 1);
    t = pow(t, 0.25); 
    float alpha = map(t, 0,1, 255, 0); 
    stroke(200,230,255, alpha);
    line(0,y, width, y); 
  }
  
  stroke(0);
  for (int x=0; x<width; x++){
    float t = millis()/1000.0 + 3.0 * map(x, 0,width, 0,1); 
    float f = noise(t);  
    float y = map(f, 0,1, height*0.60, height*0.20); 
    line(x,height, x,y); 
  }
  
}


void keyPressed(){
  if (key == 's'){
    noiseSeed(millis()); 
  }
  if (key == ' '){
    saveFrame("noise_mountains_#####.png"); 
  }
}
