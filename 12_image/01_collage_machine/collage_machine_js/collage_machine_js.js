//////////////////////////////////////////
// "Collage Machine"                    //
// Exercise on page 170 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

var chromaKeyTolerance = 10;   // for removing background  
var iterations = 32;           // each iteration 1 image is randomly pasted
var randomizeTint = true;      // apply random tint to images?
var randomizeBgColor = true;   // random background color?

// paste the result of running "ls data" in terminal:
var lsData = `
1877.jpg  2555.jpg  3140.jpg  3299.jpg  41.jpg
1955.jpg  2724.jpg  321.jpg   3300.jpg  700.jpg
2239.jpg  2725.jpg  3229.jpg  3302.jpg  789.jpg
2241.jpg  3118.jpg  3298.jpg  3303.jpg
`;

function loadImages(lsData){
  var files = lsData.replace(/\n/g," ").split(" ").filter(x=>x.length);
  for (var i = 0; i < files.length; i++){
    images.push(loadImage("data/"+files[i]));
  }
}

// distance between two colors in rgb color space
function rgbDist(a, b){
  return Math.hypot(a[0]-b[0],a[1]-b[1],a[2]-b[2]);
}

// remove background according to chroma key
function chromaKey(img, key){
  var msk = createImage(img.width,img.height);  // foreground mask
  img.loadPixels();
  msk.loadPixels();
  // paint the mask image
  for (var i = 0; i < img.pixels.length; i+=4){
    msk.pixels[i] = ((rgbDist(img.pixels.slice(i,i+4),key)<chromaKeyTolerance)?0:0xFF);
    msk.pixels[i+3]=255;
  }
  msk.updatePixels();
  // shrink and soften the mask to remove contour artifacts
  msk.filter(ERODE);
  msk.filter(ERODE);
  msk.filter(BLUR,1);
  msk.loadPixels();
  
  // combine mask and original image
  for (var i = 0; i < img.pixels.length; i+=4){
    img.pixels[i+3] = msk.pixels[i];
  }
  img.updatePixels();
}

// make the collage
function collage(images){
  shuffle(images,true);
  
  background(255);
  if (randomizeBgColor) background(random(128,255),random(128,255),random(128,255));
  
  for (var i = 0; i < iterations; i++){
    push();
    
    imageMode(CENTER);
    translate(random(width),random(height));
    rotate(random(TAU));
    scale(random(0.1,0.7));
    if (randomizeTint) tint(random(200,255),random(200,255),random(200,255));
    
    image(images[i<images.length?i:~~random(images.length)],0,0);
    
    pop();
  }
  
}

//--------------------------------------------

var images = [];
function preload(){
  loadImages(lsData);
}

function setup(){
  createCanvas(640,480);
  
  for (var i = 0; i < images.length; i++){
    print("removing background",i,"/",images.length);
    chromaKey(images[i],[255,255,255]);
  }
  collage(images);
  print("press a key to make another collage");
}

//--------------------------------------------

function draw(){

}

//--------------------------------------------

function keyPressed(){
  print("making another collage");
  collage(images);
}
