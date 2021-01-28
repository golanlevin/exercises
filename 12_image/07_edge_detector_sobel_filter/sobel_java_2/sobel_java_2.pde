// ref:
// https://aishack.in/tutorials/sobel-laplacian-edge-detectors/

PImage img;
float threshold;

void setup() {
  size(800, 800);
  img = loadImage("grace_hopper_2.jpg");
  threshold = 70;
    
  float[] kerneledH = new float[img.width * img.height];
  for (int r = 0; r < img.height; r++) {
    for (int c = 0; c < img.width; c++) {
      float p = getKernelH(r, c);
      if (p < threshold) {
        kerneledH[r*img.width + c] = 0;
      } else {
        kerneledH[r*img.width + c] = 255;
      }
      kerneledH[r*img.width + c] = p;
    }
  }
  
  float[] kerneledV = new float[img.width * img.height];
  for (int r = 0; r < img.height; r++) {
    for (int c = 0; c < img.width; c++) {
      float p = getKernelV(r, c);
      if (p < threshold) {
        kerneledV[r*img.width + c] = 0;
      } else {
        kerneledV[r*img.width + c] = 255;
      }
      kerneledV[r*img.width + c] = p;
    }
  }

  // calculate strength
  float[] strength = new float[img.width * img.height];
  for (int r = 0; r < img.height; r++) {
    for (int c = 0; c < img.width; c++) {
      strength[r*img.width + c] = sqrt(pow(kerneledV[r*img.width + c], 2) + kerneledH[r*img.width + c]);
    }
  }
  
  // calculate orientation
  float[] orientation = new float[img.width * img.height];
  for (int r = 0; r < img.height; r++) {
    for (int c = 0; c < img.width; c++) {
      orientation[r*img.width + c] = atan(kerneledV[r*img.width + c]/kerneledH[r*img.width + c]);
    }
  }
  
  // show new image
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      stroke(kerneledH[y/2 * img.width + x/2]);
      point(x, y);
    }
  }
}

float getKernelH(int r, int c) {
  float result = 0*img.pixels[r*img.width + c];
  if (c > 0) {
    if (r > 0) {
      result -= brightness(img.pixels[(r-1)*img.width + c-1]);
    }
    result -= 2*brightness(img.pixels[r*img.width + c-1]);
    if (r < img.height-1) {
      result -= brightness(img.pixels[(r+1)*img.width + c-1]);
    }
  }
  if (c < img.width-1) {
    if (r > 0) {
      result += brightness(img.pixels[(r-1)*img.width + c+1]);
    }
    result += 2*brightness(img.pixels[r*img.width + c+1]);
    if (r < img.height-1) {
      result += brightness(img.pixels[(r+1)*img.width + c+1]);
    }
  }
  return result;
}

float getKernelV(int r, int c) {
  float result = 0*img.pixels[r*img.width + c];
  if (r > 0) {
    if (c > 0) {
      result += brightness(img.pixels[(r-1)*img.width + c-1]);
    }
    result += 2*brightness(img.pixels[(r-1)*img.width + c]);
    if (c < img.width-1) {
      result += brightness(img.pixels[(r-1)*img.width + c+1]);
    }
  }
  if (r < img.height-1) {
    if (c > 0) {
      result -= brightness(img.pixels[(r+1)*img.width + c-1]);
    }
    result -= 2*brightness(img.pixels[(r+1)*img.width + c]);
    if (c < img.width-1) {
      result -= brightness(img.pixels[(r+1)*img.width + c+1]);
    }
  }
  return result;
}

void draw() {

}

void keyPressed() {
  if (key == ' ') {
    saveFrame("sobel_filter.png");
  }
}
