from glob import glob

nImages = 0;
images = None;
nPixels = None;
averageImagef = None
averagedPixelColors = None;

#======================================
def setup():
  global nPixels
  size(240, 240);
  nPixels = width*height;

  initializeArrays();
  loadImages();
  computeAverageImage();


#======================================
def draw():
  loadPixels();
  for i in range(nPixels):
    pixels[i] = averagedPixelColors[i];
  updatePixels();
  noLoop();


#======================================
def initializeArrays():
  global averageImagef, averagedPixelColors
  # make and clear the average image
  averageImagef = [[0,0,0] for _ in range(nPixels)];
  averagedPixelColors = [0 for _ in range(nPixels)];


#======================================
def loadImages():
  global images,nImages
  # This function loads and counts 
  # all of the (image) files in the data folder.
  
  # Images should all be the same size. If they're not, 
  # or if any of them are smaller than the width&height,
  # then you may get an arrayOutOfBoundsException.

  # See http:#www.flickr.com/groups/circle/pool/
  # String folderPath = selectFolder(); # choose manually, or..
  images = [loadImage(_.split("/")[1]) for _ in glob("data/*.*g")]
  nImages = len(images)


#======================================
def computeAverageImage():
  if (nImages > 0):

    for j in range(nImages):              # for each image
      for i in range(nPixels):            # for each pixel
        c = images[j].pixels[i];          # get the color of that pixel in that image
        r = red   (c);                    # extract the color components of that pixel
        g = green (c);
        b = blue  (c);
        averageImagef[i][0] += r;               # sum (accumulate) the color components
        averageImagef[i][1] += g;
        averageImagef[i][2] += b;
    
    
    for i in range(nPixels):
       # divide the sums by the number of images, to get averages
      averageImagef[i][0] /= float(nImages);
      averageImagef[i][1] /= float(nImages);
      averageImagef[i][2] /= float(nImages);
      
      # create and store new colors from these averages
      r = averageImagef[i][0];
      g = averageImagef[i][1];
      b = averageImagef[i][2];
      averagedPixelColors[i] = color (r,g,b); 


def keyPressed():
  if (key == ' '):
    saveFrame("image_averaging.png"); 
