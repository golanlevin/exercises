//////////////////////////////////////////
// "Edge Detector (Sobel Filter)"       //
// Exercise on page 170 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// read pixel with copy-border policy
float imget(float[] im, int imW, int imH, int x, int y){
  return im[int(constrain(y,0,imH-1))*imW+int(constrain(x,0,imW-1))];
}

// 2d convolution
void conv2d(float[] im,  int imW,  int imH,  
            float[] kern,int kernW,int kernH,
            float[] out){
  int khw = kernW/2;
  int khh = kernH/2;
  for (int i = 0; i < imH; i++){
    for (int j = 0; j < imW; j++){
      float s = 0;
      for (int ki = 0; ki < kernH; ki++){
        for (int kj = 0; kj < kernW; kj++){
          s += imget(im,imW,imH,j-khw+kj,i-khh+ki) * kern[ki*kernW+kj];
        }
      }
      out[i*imW+j] = s;
    }
  }
}

// sobel filter
void sobel(float[] im, int imW, int imH, float[] outDir){
  float[] tmp= new float[im.length];
  float[] gx = new float[im.length];
  float[] gy = new float[im.length];
  
  // separated 1d kernels
  float[] kern0 = {1,2, 1};
  float[] kern1 = {1,0,-1};
  
  conv2d(im, imW,imH,kern1,3,1,tmp);
  conv2d(tmp,imW,imH,kern0,1,3,gx );
  
  conv2d(im, imW,imH,kern0,3,1,tmp);
  conv2d(tmp,imW,imH,kern1,1,3,gy );
  
  // strength
  for (int i = 0; i < im.length; i++)
    im[i] = mag(gx[i],gy[i]);
  
  // direction
  if (outDir != null){
    for (int i = 0; i < im.length; i++)
      outDir[i] = atan2(gy[i],gx[i]);
  }
}

//--------------------------------------------

void setup(){
  size(768,512);
  PImage img = loadImage("kodim08.png");
  
  img.loadPixels();
  float[] im = new float[img.pixels.length];
  for (int i = 0; i < im.length; i++)
    im[i] = brightness(img.pixels[i])/255.0;
    
  float[] dir = new float[im.length];
  sobel(im,img.width,img.height,dir);
 
  float maxval = max(im);
  for (int i = 0; i < im.length; i++)
    img.pixels[i] = color(im[i]/maxval*255.0);
    
  img.updatePixels();
  image(img,0,0);
  
  // draw vector field
  int w = 10;
  stroke(255,128,0);
  for (int i = 0; i < img.height; i+=w){
    for (int j = 0; j < img.width; j+=w){
      float th = dir[i*img.width+j];
      float l  =  im[i*img.width+j]/maxval*w*1.5;
      float x = cos(th)*l, y = sin(th)*l;
      line(j,i,j+x,i+y);
    }
  }
}
