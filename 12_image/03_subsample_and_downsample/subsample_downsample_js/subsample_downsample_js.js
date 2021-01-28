var img;
var downX;
var downSize;
var subX;
var subSize;

function preload(){
  img = loadImage("data/ada_lovelace.jpg"); 
}

function setup() {
  createCanvas(800, 800);
  pixelDensity(1);
  img.loadPixels();
  downX = 33;
  subX = 5;
   
  downSize = ~~(img.width/downX);
  subSize = ~~(img.width/subX);
  
  noLoop();
}

function draw() {
  downSample();
  //subSample();
}

function subSample() {
  background(253);

  var subPixels = new Array(subSize*subSize);
  for (var y = 0; y < subSize; y++) {
    for (var x = 0; x < subSize; x++) {
      var i = 4*(y*subX*img.width+x*subX);
      subPixels[y*subSize + x] = img.pixels.slice(i,i+3);
    }
  }
  loadPixels();
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      var xx = int(map(x, 0, width, 0, subSize));
      var yy = int(map(y, 0, height, 0, subSize));
      pixels[(y*width+x)*4] = subPixels[yy*subSize+xx][0];
      pixels[(y*width+x)*4+1] = subPixels[yy*subSize+xx][1];
      pixels[(y*width+x)*4+2] = subPixels[yy*subSize+xx][2];
      pixels[(y*width+x)*4+3] = 255;
    }
  }
  updatePixels();
  
}

function downSample() {

  var downPixels = new Array(downSize*downSize);

  loadPixels();

  for (var y = 0; y < downSize; y++) {
    for (var x = 0; x < downSize; x++) {
      var r = 0;
      var g = 0;
      var b = 0;
      var count = 0;
      for (var yy = y*downX; yy < min(height, y*downX + downX); yy++) {
        for (var xx = x*downX; xx < min(width, x*downX + downX); xx++) {
          var loc = (yy*img.width + xx)*4;
          r += img.pixels[loc];
          g += img.pixels[loc+1];
          b += img.pixels[loc+2];
          count += 1;
        }
      }
      r /= count;
      g /= count;
      b /= count;
      downPixels[y*downSize + x] = [r,g,b];
    }
  }
  
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      var xx = int(map(x, 0, width, 0, downSize));
      var yy = int(map(y, 0, height, 0, downSize));
      pixels[(y*width+x)*4] = downPixels[yy*downSize+xx][0];
      pixels[(y*width+x)*4+1] = downPixels[yy*downSize+xx][1];
      pixels[(y*width+x)*4+2] = downPixels[yy*downSize+xx][2];
      pixels[(y*width+x)*4+3] = 255;
    }
  }
  updatePixels();
}
 

function keyPressed() {
  if (key == ' ') {
    save("subsample_downsample.png");
  }
}
