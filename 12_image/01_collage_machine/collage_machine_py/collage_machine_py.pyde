########################################
# "Collage Machine"                    #
# Exercise on page 170 of CCM          #
# demo code by Lingdong Huang          #
########################################

from glob import glob
from random import shuffle

chromaKeyTolerance = 10; # for removing background
iterations = 32;         # each iteration 1 image is randomly pasted
randomizeTint = True;    # apply random tint to images?
randomizeBgColor = True; # random background color?

# load images from a folder
def loadImages(folder):
  files = glob("data/*.*g")
  images = []
  for f in files:
    images.append(loadImage(f));
  return images

# distance^2 between two colors in rgb color space
def rgbDistSq(a,b):
  dr = ((a>>16)&0xFF)-((b>>16)&0xFF);
  dg = ((a>>8 )&0xFF)-((b>>8 )&0xFF);
  db = ((a    )&0xFF)-((b    )&0xFF);
  return dr*dr+dg*dg+db*db;

# remove background according to chroma key
def chromaKey(img, key):
  msk = createImage(img.width,img.height,RGB);  # foreground mask
  ret = createImage(img.width,img.height,ARGB); # result image
  img.loadPixels();
  msk.loadPixels();
  # paint the mask image
  chromaKeyToleranceSq = chromaKeyTolerance*chromaKeyTolerance;
  for i in range(len(img.pixels)):
    msk.pixels[i] = (rgbDistSq(img.pixels[i],key)>chromaKeyToleranceSq)*0xFF;
  
  msk.updatePixels();
  # shrink and soften the mask to remove contour artifacts
  msk.filter(ERODE);
  msk.filter(ERODE);
  msk.filter(BLUR,1);
  ret.loadPixels();
  msk.loadPixels();
  # combine mask and original image
  for i in range(len(img.pixels)):
    ret.pixels[i] = (img.pixels[i]&0xFFFFFF) | ((msk.pixels[i]&0xFF)<<24);
  
  ret.updatePixels();
  return ret;


# make the collage
def collage(images):
  shuffle(images);
  
  background(255);
  if (randomizeBgColor): background(random(128,255),random(128,255),random(128,255));
  
  for i in range(iterations):
    push();pushStyle();
    
    imageMode(CENTER);
    translate(random(width),random(height));
    rotate(random(TAU));
    scale(random(0.1,0.7));
    if (randomizeTint): tint(random(200,255),random(200,255),random(200,255));
    
    image(images[i if i<len(images) else int(random(len(images)))],0,0);
    
    pop();popStyle();
  
  

#--------------------------------------------

images = None;
def setup():
  global images
  size(640,480);
  images = loadImages("");
  for i in range(len(images)):
    print("removing background",i,"/",len(images));#please be very patient with python
    images[i] = chromaKey(images[i],0xFFFFFFFF);
  
  collage(images);
  println("press a key to make another collage");

#--------------------------------------------

def draw():
  pass;

#--------------------------------------------

def keyPressed():
  println("making another collage");
  collage(images);
