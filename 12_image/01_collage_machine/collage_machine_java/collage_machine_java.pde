//////////////////////////////////////////
// "Collage Machine"                    //
// Exercise on page 170 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

float chromaKeyTolerance = 10;   // for removing background
float iterations = 32;           // each iteration 1 image is randomly pasted
boolean randomizeTint = true;    // apply random tint to images?
boolean randomizeBgColor = true; // random background color?

// load images from a folder
PImage[] loadImages(String folder){
  String[] files = new java.io.File(dataPath(folder)).list();
  PImage[] images = new PImage[files.length];
  int count = 0;
  for (int i = 0; i < files.length; i++){
    images[count] = loadImage(files[i]);
    if (images[count]!=null) count++;
  }
  return java.util.Arrays.copyOf(images,count);
}

// distance between two colors in rgb color space
float rgbDist(color a, color b){
  return new PVector(red(a)-red(b),green(a)-green(b),blue(a)-blue(b)).mag();
}

// remove background according to chroma key
PImage chromaKey(PImage img, color key){
  PImage msk = createImage(img.width,img.height,RGB);  // foreground mask
  PImage ret = createImage(img.width,img.height,ARGB); // result image
  img.loadPixels();
  msk.loadPixels();
  // paint the mask image
  for (int i = 0; i < img.pixels.length; i++){
    msk.pixels[i] = ((rgbDist(img.pixels[i],key)<chromaKeyTolerance)?0:0xFF);
  }
  msk.updatePixels();
  // shrink and soften the mask to remove contour artifacts
  msk.filter(ERODE);
  msk.filter(ERODE);
  msk.filter(BLUR,1);
  ret.loadPixels();
  msk.loadPixels();
  // combine mask and original image
  for (int i = 0; i < img.pixels.length; i++){
    ret.pixels[i] = (img.pixels[i]&0xFFFFFF) | ((msk.pixels[i]&0xFF)<<24);
  }
  ret.updatePixels();
  return ret;
}

// make the collage
void collage(PImage[] images){
  java.util.Collections.shuffle(java.util.Arrays.asList(images));
  
  background(255);
  if (randomizeBgColor) background(random(128,255),random(128,255),random(128,255));
  
  for (int i = 0; i < iterations; i++){
    push();pushStyle();
    
    imageMode(CENTER);
    translate(random(width),random(height));
    rotate(random(TAU));
    scale(random(0.1,0.7));
    if (randomizeTint) tint(random(200,255),random(200,255),random(200,255));
    
    image(images[i<images.length?i:(int)random(images.length)],0,0);
    
    pop();popStyle();
  }
  
}

//--------------------------------------------

PImage[] images;
void setup(){
  size(640,480);
  images = loadImages("");
  for (int i = 0; i < images.length; i++){
    images[i] = chromaKey(images[i],0xFFFFFFFF);
  }
  collage(images);
  println("press a key to make another collage");
}

//--------------------------------------------

void draw(){

}

//--------------------------------------------

void keyPressed(){
  println("making another collage");
  collage(images);
}
