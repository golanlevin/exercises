// Use k-means (k=5) to calculate an optimal palette for an image. 
// Basically k-means clustering in 3D (RGB) space, run over all the 
// img.pixels in the image. 

// Helpful resource:
// https://www.baeldung.com/java-k-means-clustering-algorithm
var img;
var k;
var centroids;
var mappings;
  
function preload() {
  img = loadImage("data/jzg.jpg");  // image size needs to be the same size as canvas
}

function setup() {
  createCanvas(800, 800);
    
  background(253);
  image(img, 0, 0);
  
  img.loadPixels();
  
  k = 5;
  centroids = [];
  mappings = []; // a mapping from index of pixel to the index of centroid
  
  for (var i = 0; i < img.width * img.height; i++) {
    mappings.push(0);
  }
  
  initializeCentroids();

  KMeans();
}

function draw() {
  
  stroke(255);
  strokeWeight(2);
  
  var w = width/5-30;
  
  for (var i = 0; i < k; i++) {
    fill(centroids[i]);
    square(width*4/5, height/10 + height*i/5 - w/2, w);
  }
  
  noLoop();
}

function KMeans() {
  
  var updated = true;
  
  while (true) {
    
    console.log("...");
    
    updated = false;
    for (var i = 0; i < img.width * img.height; i++) {
      // assign each pixel to its closest centroid
      var u = updateAssignment(i);
      if (u) { 
        updated = true;
      }
    }
    
    if (!updated) {
      // didn't reassign any item to a different centroid; finish clustering 
      console.log("Finished clustering");
      break;
    }
    
    // update centroids
    updateCentroids();
  }
}

function initializeCentroids() {
  // initialize centroids to be five existing colors in the image
  for (var i = 0; i < k; i++) {
    var start = int(1.0 * img.width * img.height*i/k);
    centroids.push(getPixel(start));
  }
  console.log("Initialized..");
  console.log(centroids);
}

function getPixel(index) {
  return color(img.pixels[index*4], img.pixels[index*4+1], img.pixels[index*4+2]);
}

function updateAssignment(index) {
  var curPixel = getPixel(index);
  var prevAssignment = mappings[index];
  
  var closestCentroid = -1;
  var closestDistance = 999999;
  for (var c = 0; c < k; c++) {
    var curCentroid = centroids[c];
    var curDist = getDistance(curCentroid, curPixel);
    if (curDist < closestDistance) {
      closestCentroid = c;
      closestDistance = curDist;
    }
  }
  //prvarln(index, prevAssignment, closestCentroid);
  mappings[index] = closestCentroid;
  
  // return true if closest centroid is updated
  if (closestCentroid == prevAssignment) {
    return false;
  } else {
    return true;
  }
}

function updateCentroids() {
  var accums = [];
  var counts = [];
  for (var i = 0; i<k; i++) {
    accums.push(createVector(0, 0, 0));
    counts.push(0);
  }
  
  for (i = 0; i< img.width * img.height; i++) {
    var centroid = mappings[i];
    var curColor = getPixel(i);
    accums[centroid].add(createVector(red(curColor), green(curColor), blue(curColor)));
    counts[centroid] += 1;
  }
  
  for (i = 0; i<k; i++) {
    accums[i].div(counts[i]);
    centroids[i] = color(accums[i].x, accums[i].y, accums[i].z);
  }
  
  console.log(centroids);
}

function getDistance(c1, c2) {
  var sum = pow((red(c1)-red(c2)), 2) 
              + pow((green(c1)-green(c2)), 2) 
              + pow((blue(c1)-blue(c2)), 2);
  var dist = sqrt(sum);
  return dist;
}
