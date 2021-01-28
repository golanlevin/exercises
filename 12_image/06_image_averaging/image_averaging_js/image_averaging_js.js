var nImages = 0;
var images;
var nPixels;
var averageImagef;
var averagedPixelColors;

// paste the result of running "ls data" in terminal:
var lsData = `
141197346_93e0117ecc_m.jpg  275103868_7ba67fdebe_m.jpg
183437063_9f49c8e059_m.jpg  362858139_28958238f6_m.jpg
240446130_b12b272212_m.jpg  389025714_b0df1f6056_m.jpg
24895023_56286408f5_m.jpg   393157522_b39115c615_m.jpg
255447106_cafcac726b_m.jpg  57560963_2cf7d45f6c_m.jpg
`;

function preload(){
  loadImages();
}

//======================================
function setup(){
  createCanvas(240, 240);
  pixelDensity(1);
  nPixels = width*height;

  initializeArrays();
  
  computeAverageImage();
}

//======================================
function draw(){
  loadPixels();
  for (var i=0; i<nPixels; i++){
    pixels[i*4  ] =   red(averagedPixelColors[i]);
    pixels[i*4+1] = green(averagedPixelColors[i]);
    pixels[i*4+2] =  blue(averagedPixelColors[i]);
    pixels[i*4+3] = 255;
  }
  updatePixels();
  noLoop();
}

//======================================
function initializeArrays(){
  // make and clear the average image
  averageImagef = new Array(nPixels).fill(null).map(_=>[0,0,0]);
  averagedPixelColors = new Array(nPixels).fill(0);
}

//======================================
function loadImages(){
  // This function loads and counts 
  // all of the (image) files in the data folder.
  
  // Images should all be the same size. If they're not, 
  // or if any of them are smaller than the width&height,
  // then you may get an arrayOutOfBoundsException.

  // See http://www.flickr.com/groups/circle/pool/
  // String folderPath = selectFolder(); // choose manually, or..
  var files = lsData.replace(/\n/g," ").split(" ").filter(x=>x.length);
  images = files.map(_=>loadImage("data/"+_));
  nImages = images.length;
}


//======================================
function computeAverageImage(){
  if (nImages > 0){

    for (var j=0; j<nImages; j++){              // for each image
      images[j].loadPixels();
      for (var i=0; i<nPixels; i++){            // for each pixel
        var c=images[j].pixels.slice(i*4,i*4+3);// get the color of that pixel in that image
        var r =        c[0];                    // extract the color components of that pixel
        var g =        c[1];
        var b =        c[2];
        averageImagef[i][0] += r;               // sum (accumulate) the color components
        averageImagef[i][1] += g;
        averageImagef[i][2] += b;
      }
    }
    
    for (var i=0; i<nPixels; i++){
       // divide the sums by the number of images, to get averages
      averageImagef[i][0] /= nImages;
      averageImagef[i][1] /= nImages;
      averageImagef[i][2] /= nImages;
      
      // create and store new colors from these averages
      var r = averageImagef[i][0];
      var g = averageImagef[i][1];
      var b = averageImagef[i][2];
      averagedPixelColors[i] = color (r,g,b); 
    }
 
    
  }
}


function keyPressed(){
  if (key == ' '){
    save("image_averaging.png"); 
  }
}
