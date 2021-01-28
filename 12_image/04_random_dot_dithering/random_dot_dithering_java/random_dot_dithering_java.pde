PImage img;

void setup() {
  size(800, 800, FX2D);
  img = loadImage("lillian_schwartz.jpg");//grace_hopper_3.png");

  background(253);
  fill(0);
  noStroke();
}

void draw() {
  int dotsPerFrame = 20; 
  
  stroke(0); 
  strokeWeight(4.5); 
  strokeCap(ROUND); 
  
  for (int i=0; i<dotsPerFrame; i++){
    int x = int(random(img.width));
    int y = int(random(img.height));
    float b = brightness(img.pixels[y*img.width + x]);
    b = 255.0 * pow((b/255.0), 0.75);

    if (random(255) > b) {
      float xx = map(x, 0, img.width, 0, width);
      float yy = map(y, 0, img.height, 0, height);
      point(xx,yy); 
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("random_dot_dithering-####.png");
  }
}
