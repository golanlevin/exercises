########################################
# "Palette from Photo"                 #
# or k-means clustering                #
# Exercise on page 156 of CCM          #
# demo code by Lingdong Huang          #
########################################

numClusters = 5;  # number of colors in the palette
useHSB = False;   # use HSB color space instead of RGB?
useForgy = False; # use Forgy initialization instead of
                  # random partition?

# datastructure for a point
class Point:
  pos = None; # coordinate of point
  cluster = None;
    # ^ for data points, this is cluster ID
    # for cluster centers, this is number of points
    # in the cluster

# recompute cluster centers from the points in the cluster
def recomputeCenters(centers,pts):
  nClusters = len(centers);
  for i in range(nClusters):
    centers[i].pos.mult(0);
    centers[i].cluster = 0;
  
  for i in range(len(pts)):
    c = pts[i].cluster;
    centers[c].pos.add(pts[i].pos);
    centers[c].cluster +=1;
  
  for i in range(nClusters):
    if (centers[i].cluster>0):
      centers[i].pos.div(float(centers[i].cluster));
    
# recompute point clusterings from point coordinates
def recomputePoints(centers,pts):
  nClusters = len(centers);
  diff = False; # anything changed? nothing->done
  
  # find closest cluster center to attach the point
  for i in range(len(pts)):
    dstmin = float('inf');
    argmin = 0;
    for j in range(nClusters):
      d = pts[i].pos.dist(centers[j].pos);
      if (d < dstmin):
        dstmin = d;
        argmin = j;
        
    if (argmin != pts[i].cluster):
      diff = True;
    
    pts[i].cluster = argmin;
  
  return diff;


# "The Random Partition method first randomly 
# assigns a cluster to each observation and then 
# proceeds to the update step"
# -- https://en.wikipedia.org/wiki/K-means_clustering
def initRandPart(pts, centers):
  nClusters = len(centers);
  for i in range(len(pts)):
    pts[i].cluster = int(random(nClusters));
  
  for i in range(nClusters):
    centers[i] = Point();
    centers[i].pos = PVector();
  


# "The Forgy method randomly chooses k observations 
# from the dataset and uses these as the initial means." 
# -- https://en.wikipedia.org/wiki/K-means_clustering
def initForgy(pts, centers):
  nClusters = len(centers);
  used = [False for _ in pts]
  for i in range(nClusters):
    j = 0;
    while True:
      j = int(random(len(pts)));
      if (not used[j]):
        break;
    used[j] = True;
    centers[i] = Point();
    centers[i].pos = pts[j].pos.copy();
  
  recomputePoints(centers,pts);


# run kmeans algorithm
def kmeans(pts, nClusters, maxIter):
  centers = [False for _ in range(nClusters)]
  if (useForgy):
    initRandPart(pts,centers);
  else:
    initForgy(pts,centers);
  
  for iter in range(maxIter):
    print("Please wait....", iter, "of", maxIter);
    recomputeCenters(centers,pts);
    if (not recomputePoints(centers,pts)):
      break; # no change, done!
    
  return centers;


# compute palette of image
def palette(img,nClusters):
  img.loadPixels();
  pts = [None for _ in img.pixels]
  for i in range(len(img.pixels)):
    pts[i] = Point();
    if (useHSB):
      pts[i].pos = PVector(
        float(       hue(img.pixels[i])/255.0),
        float(saturation(img.pixels[i])/255.0),
        float(brightness(img.pixels[i])/255.0)
      );
    else:
      pts[i].pos = PVector(
        float(  red(img.pixels[i])/255.0),
        float(green(img.pixels[i])/255.0),
        float( blue(img.pixels[i])/255.0)
      );
    
  centers = kmeans(pts,nClusters,300);

  # return centers and datapoints in the same array
  return centers+pts;



#--------------------------------------------

def setup():
  if (useHSB): colorMode(HSB,255,255,255);
  
  size(640,512);

  img = loadImage("airplane.png"); # try peppers.png
  
  ret = palette(img,numClusters);
  centers = ret[0:numClusters];
  pts     = ret[numClusters:];
  
  # posterize in-place
  img.loadPixels();
  for i in range(len(img.pixels)):
    c = centers[pts[i].cluster].pos;
    img.pixels[i] = color(c.x*255,c.y*255,c.z*255);
  
  img.updatePixels();
  image(img,0,0,height,height);

  # draw the palette
  translate(height,0);
  gridH = float(height)/float(numClusters);
  for i in range(numClusters):
    c =      color(255*centers[i].pos.x,
                   255*centers[i].pos.y,
                   255*centers[i].pos.z);
    fill(c);
    rect(0,i*gridH,width-height,gridH);
    
    fill((~c)|0xFF000000); # inverted color for text
    text("#"+hex(c,6),5,i*gridH+15);
  
