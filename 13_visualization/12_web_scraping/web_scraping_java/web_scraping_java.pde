

ArrayList<PImage> images; 

void setup() {
  noLoop();
  size(800, 800);

  String dir = sketchPath() + "/data/";
  String[] imageFilenames = listFileNames(dir);
  images = new ArrayList<PImage>(); 
  for (int i=0; i<imageFilenames.length; i++) {
    if (imageFilenames[i].endsWith(".jpg")) {
      PImage img = loadImage(imageFilenames[i]);
      images.add(img);
    }
  }
}


//===================================
void draw() {
  background(255);

  int NX = 7; 
  int NY = 7; 
  float margin = 40;
  for (int i=0; i<images.size(); i++) {
    PImage img = images.get(i); 
    float pw = (float)(width - 2*margin) / (float)NX;
    float ph = ((float)img.height / (float)img.width) * pw;

    float px = (i%NX) * pw + margin;
    float py = (i/NX) * ph + margin;
    image(img, px, py, pw, ph);
  }
}

//===================================
void keyPressed() {
  if (key == ' ') {
    saveFrame("web_scraping.png");
  }
}

//===================================
// https://processing.org/examples/directorylist.html
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
