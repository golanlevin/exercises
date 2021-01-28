// Use k-means (k=5) to calculate an optimal palette for an image. 
// Basically k-means clustering in 3D (RGB) space, run over all the 
// pixels in the image. 

// Helpful resource:
// https://www.baeldung.com/java-k-means-clustering-algorithm


PImage img;
int k;
color[] centroids;
int[] mappings;
  
void setup() {
  size(800, 800);
  img = loadImage("jzg.jpg");  // image size needs to be the same size as canvas
  
  background(253);
  image(img, 0, 0);
  loadPixels();
  
  k = 5;
  centroids = new color[k];
  mappings = new int[pixels.length]; // a mapping from index of pixel to the index of centroid
  initializeCentroids();

  KMeans();
}

void draw() {
  
  stroke(255);
  strokeWeight(2);
  
  float w = width/5-30;
  
  for (int i = 0; i < k; i++) {
    fill(centroids[i]);
    square(width*4/5, height/10 + height*i/5 - w/2, w);
  }
  
  noLoop();
}

void KMeans() {
  
  boolean updated = true;
  
  while (true) {
    
    println("...");
    
    updated = false;
    for (int i = 0; i < pixels.length; i++) {
      // assign each pixel to its closest centroid
      boolean u = updateAssignment(i);
      if (u) updated = true;
    }
    
    if (!updated) {
      // didn't reassign any item to a different centroid; finish clustering 
      println("Finished clustering");
      break;
    }
    
    // update centroids
    updateCentroids();
  }
}

void initializeCentroids() {
  // initialize centroids to be five existing colors in the image
  for (int i = 0; i < k; i++) {
    centroids[i] = pixels[int(1.0 * pixels.length*i/k)];
  }
}

boolean updateAssignment(int index) {
  color curPixel = pixels[index];
  int prevAssignment = mappings[index];
  
  int closestCentroid = -1;
  float closestDistance = Integer.MAX_VALUE;
  for (int c = 0; c < k; c++) {
    color curCentroid = centroids[c];
    float curDist = getDistance(curCentroid, curPixel);
    if (curDist < closestDistance) {
      closestCentroid = c;
      closestDistance = curDist;
    }
  }
  //println(index, prevAssignment, closestCentroid);
  mappings[index] = closestCentroid;
  
  // return true if closest centroid is updated
  if (closestCentroid == prevAssignment) {
    return false;
  } else {
    return true;
  }
}

void updateCentroids() {
  PVector[] accums = new PVector[k];
  int[] counts = new int[k];
  for (int i = 0; i<k; i++) {
    accums[i] = new PVector(0, 0, 0);
    counts[i] = 0;
  }
  
  for (int i = 0; i<pixels.length; i++) {
    int centroid = mappings[i];
    int curColor = pixels[i];
    accums[centroid].add(new PVector(red(curColor), green(curColor), blue(curColor)));
    counts[centroid] += 1;
  }
  
  for (int i = 0; i<k; i++) {
    accums[i].div(counts[i]);
    centroids[i] = color(accums[i].x, accums[i].y, accums[i].z);
  }
}

float getDistance(color c1, color c2) {
  float sum = pow((red(c1)-red(c2)), 2) 
              + pow((green(c1)-green(c2)), 2) 
              + pow((blue(c1)-blue(c2)), 2);
  float dist = sqrt(sum);
  return dist;
}

void keyPressed(){
  if (key == ' ') {
    saveFrame("palette.png"); 
  }
}
