// Exercises: Arrays
// Animated walk cycle

PImage frames[]; // Array for image frames
int currentFrame = 0;

void setup() {
  size(800, 800);
  frameRate(12); // 12 frames per second 

  // Load frames into the array.
  frames = new PImage[15];
  for (int i=0; i<frames.length; i++) {
    String numStr = nf(i, 2);
    frames[i]=loadImage("frame_" + numStr + ".png");
  }
}

void draw() {
  background(0);
  image(frames[currentFrame], 0, 100, frames[currentFrame].width*8/3, frames[currentFrame].height*8/3);

  if (currentFrame < frames.length-1) { 
    currentFrame++; // increase frame variable
  } else {
    currentFrame=0; // reset to loop beginning
  }
}
