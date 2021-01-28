########################################
# "Edge Detector (Sobel Filter)"       #
# Exercise on page 170 of CCM          #
# demo code by Lingdong Huang          #
########################################

# read pixel with copy-border policy
def imget(im, imW, imH, x, y):
  return im[int(constrain(y,0,imH-1))*imW+int(constrain(x,0,imW-1))];

# 2d convolution
def conv2d(im, imW, imH, kern, kernW, kernH, out):
  khw = floor(kernW/2);
  khh = floor(kernH/2);
  for i in range(imH):
    for j in range(imW):
      s = 0;
      for ki in range(kernH):
        for kj in range(kernW):
          s += imget(im,imW,imH,j-khw+kj,i-khh+ki) * kern[ki*kernW+kj];
      out[i*imW+j] = s;

# sobel filter
def sobel(im, imW, imH, outDir):
  tmp= [0]*len(im);
  gx = [0]*len(im);
  gy = [0]*len(im);
  
  # separated 1d kernels
  kern0 = [1,2, 1];
  kern1 = [1,0,-1];
  print("1/5");
  conv2d(im, imW,imH,kern1,3,1,tmp);
  print("2/5");
  conv2d(tmp,imW,imH,kern0,1,3,gx );
  print("3/5");
  conv2d(im, imW,imH,kern0,3,1,tmp);
  print("4/5");
  conv2d(tmp,imW,imH,kern1,1,3,gy );
  
  print("5/5");
  # strength
  for i in range(len(im)):
    im[i] = mag(gx[i],gy[i]);
  
  # direction
  if (outDir != None):
    for i in range(len(im)):
      outDir[i] = atan2(gy[i],gx[i]);

#--------------------------------------------


def setup():
  size(768,512);

  img = loadImage("kodim08.png");

  img.loadPixels();
  im = [0]*len(img.pixels);
  
  for i in range(len(im)):
    im[i] = brightness(img.pixels[i])/255.0;
    
  dir = [0]*len(im);
  sobel(im,img.width,img.height,dir);
 
  maxval = max(im);
  for i in range(len(im)):
    img.pixels[i] = color(im[i]/maxval*255.0);
    
  img.updatePixels();
  image(img,0,0);
  
  # draw vector field
  w = 10;
  stroke(255,128,0);
  for i in range(0,img.height,w):
    for j in range(0,img.width,w):
      th = dir[i*img.width+j];
      l  =  im[i*img.width+j]/maxval*w*1.5;
      x = cos(th)*l; y = sin(th)*l;
      line(j,i,j+x,i+y);
