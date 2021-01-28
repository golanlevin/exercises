img = None;
downX = None;
downSize = None;
subX = None;
subSize = None;


def setup():
  global img,downX,downSize,subX,subSize
  size(800, 800);
  img = loadImage("ada_lovelace.jpg"); 
  
  downX = 33;
  subX = 5;
   
  downSize = int(img.width/downX);
  subSize = int(img.width/subX);
  
  noLoop();


def draw():
  downSample();
  #subSample();

def subSample():
  global img,downX,downSize,subX,subSize
  background(253);

  subPixels = [None]*(subSize*subSize);
  for y in range(subSize):
    for x in range(subSize):
      subPixels[y*subSize + x] = img.pixels[y*subX*img.width + x*subX];
    
  
  loadPixels();
  for y in range(height):
    for x in range(width):
      xx = int(map(x, 0, width, 0, subSize));
      yy = int(map(y, 0, height, 0, subSize));
      pixels[y*width+x] = subPixels[yy*subSize+xx];
    
  updatePixels();
  

def downSample():
  global img,downX,downSize,subX,subSize
  
  downPixels = [None]*(downSize*downSize);

  loadPixels();

  for y in range(downSize):
    for x in range(downSize):
      r = 0;
      g = 0;
      b = 0;
      count = 0;
      for yy in range(y*downX,min(height, y*downX + downX)):
        for xx in range(x*downX,min(width, x*downX + downX)):
          loc = yy*img.width + xx;
          r += red(img.pixels[loc]);
          g += green(img.pixels[loc]);
          b += blue(img.pixels[loc]);
          count += 1;
        
      r /= count;
      g /= count;
      b /= count;
      downPixels[y*downSize + x] = color(r, g, b);
    
  for y in range(height):
    for x in range(width):
      xx = int(map(x, 0, width, 0, downSize));
      yy = int(map(y, 0, height, 0, downSize));
      pixels[y*width+x] = downPixels[yy*downSize+xx];
    
  updatePixels();
 

def keyPressed():
  if (key == ' '):
    saveFrame("subsample_downsample.png");
  
