//////////////////////////////////////////
// "Edge Detector (Sobel Filter)"       //
// Exercise on page 170 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// read pixel with copy-border policy
function imget(im, imW, imH, x, y){
  return im[int(constrain(y,0,imH-1))*imW+int(constrain(x,0,imW-1))];
}

// 2d convolution
function conv2d(im, imW, imH, kern, kernW, kernH, out){
  var khw = ~~(kernW/2);
  var khh = ~~(kernH/2);
  for (var i = 0; i < imH; i++){
    for (var j = 0; j < imW; j++){
      var s = 0;
      for (var ki = 0; ki < kernH; ki++){
        for (var kj = 0; kj < kernW; kj++){
          s += imget(im,imW,imH,j-khw+kj,i-khh+ki) * kern[ki*kernW+kj];
        }
      }
      out[i*imW+j] = s;
    }
  }
}

// sobel filter
function sobel(im, imW, imH, outDir){
  var tmp= new Array(im.length);
  var gx = new Array(im.length);
  var gy = new Array(im.length);
  
  // separated 1d kernels
  var kern0 = [1,2, 1];
  var kern1 = [1,0,-1];
  
  conv2d(im, imW,imH,kern1,3,1,tmp);
  conv2d(tmp,imW,imH,kern0,1,3,gx );
  
  conv2d(im, imW,imH,kern0,3,1,tmp);
  conv2d(tmp,imW,imH,kern1,1,3,gy );
  
  // strength
  for (var i = 0; i < im.length; i++)
    im[i] = mag(gx[i],gy[i]);
  
  // direction
  if (outDir != null){
    for (var i = 0; i < im.length; i++)
      outDir[i] = atan2(gy[i],gx[i]);
  }
}

//--------------------------------------------

var img;

function preload(){
  img = loadImage("data/kodim08.png");
}

function setup(){
  createCanvas(img.width,img.height);
  
  img.loadPixels();
  var im = new Array(img.pixels.length/4);
  
  for (var i = 0; i < im.length; i++)
    im[i] = brightness(color(
      img.pixels[i*4],img.pixels[i*4+1],img.pixels[i*4+2]
    ))/255.0;
    
  var dir = new Array(im.length);
  sobel(im,img.width,img.height,dir);

  var maxval = im.reduce((a,b)=>max(a,b),0);
  for (var i = 0; i < im.length; i++)
    img.pixels[i*4]   = 
    img.pixels[i*4+1] = 
    img.pixels[i*4+2] = im[i]/maxval*255.0;
    
  img.updatePixels();
  image(img,0,0);
  
  // draw vector field
  var w = 10;
  stroke(255,128,0);
  for (var i = 0; i < img.height; i+=w){
    for (var j = 0; j < img.width; j+=w){
      var th = dir[i*img.width+j];
      var l  =  im[i*img.width+j]/maxval*w*1.5;
      var x = cos(th)*l, y = sin(th)*l;
      line(j,i,j+x,i+y);
    }
  }
}
