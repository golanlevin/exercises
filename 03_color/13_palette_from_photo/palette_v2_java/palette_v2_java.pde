//////////////////////////////////////////
// "Palette from Photo"                 //
// or k-means clustering                //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

int numClusters = 5;      // number of colors in the palette
boolean useHSB = false;   // use HSB color space instead of RGB?
boolean useForgy = false; // use Forgy initialization instead of
                          // random partition?

// datastructure for a point
class Point{
  PVector pos; // coordinate of point
  int cluster;
    // ^ for data points, this is cluster ID
    // for cluster centers, this is number of points
    // in the cluster
}

// recompute cluster centers from the points in the cluster
void recomputeCenters(Point[] centers,Point[] pts){
  int nClusters = centers.length;
  for (int i = 0; i < nClusters; i++){
    centers[i].pos.mult(0);
    centers[i].cluster = 0;
  }
  for (int i = 0; i < pts.length; i++){
    int c = pts[i].cluster;
    centers[c].pos.add(pts[i].pos);
    centers[c].cluster ++;
  }
  for (int i = 0; i < nClusters; i++){
    if (centers[i].cluster>0){
      centers[i].pos.div((float)centers[i].cluster);
    }
  }
}

// recompute point clusterings from point coordinates
boolean recomputePoints(Point[] centers,Point[] pts){
  int nClusters = centers.length;
  boolean diff = false; // anything changed? nothing->done
  
  //find closest cluster center to attach the point
  for (int i = 0; i < pts.length; i++){
    float dstmin = Float.POSITIVE_INFINITY;
    int argmin = 0;
    for (int j = 0; j < nClusters; j++){
      float d = pts[i].pos.dist(centers[j].pos);
      if (d < dstmin){
        dstmin = d;
        argmin = j;
      }
    }
    if (argmin != pts[i].cluster){
      diff = true;
    }
    pts[i].cluster = argmin;
  }
  return diff;
}

// "The Random Partition method first randomly 
// assigns a cluster to each observation and then 
// proceeds to the update step"
// -- https://en.wikipedia.org/wiki/K-means_clustering
void initRandPart(Point[] pts, Point[] centers){
  int nClusters = centers.length;
  for (int i = 0; i < pts.length; i++){
    pts[i].cluster = (int)random(nClusters);
  }
  for (int i = 0; i < nClusters; i++){
    centers[i] = new Point();
    centers[i].pos = new PVector();
  }
}

// "The Forgy method randomly chooses k observations 
// from the dataset and uses these as the initial means." 
// -- https://en.wikipedia.org/wiki/K-means_clustering
void initForgy(Point[] pts, Point[] centers){
  int nClusters = centers.length;
  boolean[] used = new boolean[pts.length];
  for (int i = 0; i < nClusters; i++){
    int j;
    do{
      j = (int)random(pts.length);
    }while(used[j]);
    used[j] = true;
    centers[i] = new Point();
    centers[i].pos = pts[j].pos.copy();
  }
  recomputePoints(centers,pts);
}

// run kmeans algorithm
Point[] kmeans(Point[] pts, int nClusters, int maxIter){
  Point[] centers = new Point[nClusters];
  if (useForgy){
    initRandPart(pts,centers);
  }else{
    initForgy(pts,centers);
  }
  for (int iter = 0; iter < maxIter; iter++){
    recomputeCenters(centers,pts);
    if (!recomputePoints(centers,pts)){
      break; // no change, done!
    }
  }
  return centers;
}

// compute palette of image
Point[] palette(PImage img,int nClusters){
  img.loadPixels();
  Point[] pts = new Point[img.pixels.length];
  for (int i = 0; i < img.pixels.length; i++){
    pts[i] = new Point();
    if (useHSB){
      pts[i].pos = new PVector(
        (float)       hue(img.pixels[i])/255.0,
        (float)saturation(img.pixels[i])/255.0,
        (float)brightness(img.pixels[i])/255.0
      );
    }else{
      pts[i].pos = new PVector(
        (float)  red(img.pixels[i])/255.0,
        (float)green(img.pixels[i])/255.0,
        (float) blue(img.pixels[i])/255.0
      );
    }
  }
  Point[] centers = kmeans(pts,nClusters,300);

  // return centers and datapoints in the same array
  return (Point[])concat(centers,pts);
}


//--------------------------------------------

void setup(){
  if (useHSB) colorMode(HSB,255,255,255);
  
  size(640,512);

  PImage img = loadImage("airplane.png"); // try peppers.png
  
  Point[] ret = palette(img,numClusters);
  Point[] centers = (Point[])subset(ret,0,numClusters);
  Point[] pts     = (Point[])subset(ret,numClusters);
  
  // posterize in-place
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++){
    PVector c = centers[pts[i].cluster].pos;
    img.pixels[i] = color(c.x*255,c.y*255,c.z*255);
  }
  img.updatePixels();
  image(img,0,0,height,height);

  // draw the palette
  translate(height,0);
  float gridH = (float)height/(float)numClusters;
  for (int i = 0; i < numClusters; i++){
    color c= color(255*centers[i].pos.x,
                   255*centers[i].pos.y, 
                   255*centers[i].pos.z);
    fill(c);
    rect(0,i*gridH,width-height,gridH);
    
    fill((~c)|0xFF000000); // inverted color for text
    text("#"+hex(c,6),5,i*gridH+15);
  }
}
