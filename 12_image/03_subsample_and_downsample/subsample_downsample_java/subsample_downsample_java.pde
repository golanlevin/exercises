PImage img;
int downX;
int downSize;
int subX;
int subSize;


void setup() {
  size(800, 800);
  img = loadImage("ada_lovelace.jpg"); 
  
  downX = 33;
  subX = 5;
   
  downSize = img.width/downX;
  subSize = img.width/subX;
  
  noLoop();
}

void draw() {
  downSample();
  //subSample();
}

void subSample() {
  background(253);

  color[] subPixels = new color[subSize*subSize];
  for (int x = 0; x < subSize; x++) {
    for (int y = 0; y < subSize; y++) {
      subPixels[y*subSize + x] = img.pixels[y*subX*img.width + x*subX];
    }
  }
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int xx = int(map(x, 0, width, 0, subSize));
      int yy = int(map(y, 0, height, 0, subSize));
      pixels[y*width+x] = subPixels[yy*subSize+xx];
    }
  }
  updatePixels();
  
}

void downSample() {
  
  color[] downPixels = new color[downSize*downSize];

  loadPixels();

  for (int x = 0; x < downSize; x++) {
    for (int y = 0; y < downSize; y++) {
      float r = 0;
      float g = 0;
      float b = 0;
      int count = 0;
      for (int xx = x*downX; xx < min(width, x*downX + downX); xx++) {
        for (int yy = y*downX; yy < min(height, y*downX + downX); yy++) {
          int loc = yy*img.width + xx;
          r += red(img.pixels[loc]);
          g += green(img.pixels[loc]);
          b += blue(img.pixels[loc]);
          count += 1;
        }
      }
      r /= count;
      g /= count;
      b /= count;
      downPixels[y*downSize + x] = color(r, g, b);
    }
  }
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int xx = int(map(x, 0, width, 0, downSize));
      int yy = int(map(y, 0, height, 0, downSize));
      pixels[y*width+x] = downPixels[yy*downSize+xx];
    }
  }
  updatePixels();
}
 

void keyPressed() {
  if (key == ' ') {
    saveFrame("subsample_downsample.png");
  }
}
