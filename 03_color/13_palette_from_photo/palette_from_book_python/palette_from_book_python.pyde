# Use k-means (k=5) to calculate an optimal palette for an image. 
# Basically k-means clustering in 3D (RGB) space, run over all the 
# pixels in the image. 

# Helpful resource:
# https:#www.baeldung.com/java-k-means-clustering-algorithm


img, k, centroids, mappings = None, 0, [], []

def setup():
  size(800, 800)
  
  global img, k, centroids, mappings
  
  img = loadImage("jzg.jpg")  # image size needs to be the same size as canvas
  
  background(253)
  image(img, 0, 0)
  loadPixels()
  
  k = 5
  centroids = [0, 0, 0, 0, 0] * k
  mappings = [0] * len(pixels) # a mapping from index of pixel to the index of centroid
  initializeCentroids()

  KMeans()


def draw():
    
  global img, k, centroids, mappings
  
  stroke(255)
  strokeWeight(2)
  
  w = width/5-30
  
  for i in range(k):
    fill(centroids[i])
    square(width*4/5, height/10 + height*i/5 - w/2, w)
  
  noLoop()


def KMeans():
  
  updated = True
  
  while (True):
    
    println("updating..")
    updated = False
    for i in range(len(pixels)):
      # assign each pixel to its closest centroid
      u = updateAssignment(i)
      if (u): 
        updated = True
    
    if (not updated):
      # didn't reassign any item to a different centroid finish clustering 
      println("Finished clustering")
      break
    
    # update centroids
    updateCentroids()
  


def initializeCentroids():
  # initialize centroids to be five existing colors in the image
  
  global centroids, k
  for i in range(k):
    centroids[i] = pixels[int(1.0 * len(pixels)*i/k)]
  


def updateAssignment(index):
    
  global centroids, k, mappings
  
  curPixel = pixels[index]
  prevAssignment = mappings[index]
  
  closestCentroid = -1
  closestDistance = 9999999
  for c in range(k):
    curCentroid = centroids[c]
    curDist = getDistance(curCentroid, curPixel)
    if (curDist < closestDistance):
      closestCentroid = c
      closestDistance = curDist
    
  #println(index, prevAssignment, closestCentroid)
  mappings[index] = closestCentroid
  
  # return True if closest centroid is updated
  if (closestCentroid == prevAssignment):
    return False
  else:
    return True
  

def updateCentroids():
  global centroids, k, mappings
  
  accums = [None] * k
  counts = [0] * k
  for i in range(k):
    accums[i] = PVector(0, 0, 0)
    counts[i] = 0
  
  
  for i in range(len(pixels)):
    centroid = mappings[i]
    curColor = pixels[i]
    accums[centroid].add(PVector(red(curColor), green(curColor), blue(curColor)))
    counts[centroid] += 1
  
  for i in range(k):
    accums[i].div(counts[i])
    centroids[i] = color(accums[i].x, accums[i].y, accums[i].z)
  


def getDistance(c1, c2):
  sum = pow((red(c1)-red(c2)), 2) + pow((green(c1)-green(c2)), 2) + pow((blue(c1)-blue(c2)), 2)
  dist = sqrt(sum)
  return dist
