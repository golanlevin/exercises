var criterion = "hue"
// criterion = "saturation"
// criterion = "brightness"

var img;
function preload(){
  img = loadImage("data/j.jpg");
}

function setup(){
  criterion = window[criterion];
  createCanvas(800,800);
  img.loadPixels();
  
  new Array(img.pixels.length/4).fill(null).map((_,i)=>img.pixels.slice(i*4,i*4+3)).sort((a,b)=>criterion(color(...a))-criterion(color(...b))).map((x,i)=>{[img.pixels[i*4],img.pixels[i*4+1],img.pixels[i*4+2]]=x});
    
  img.updatePixels();
  image(img,0,0);
}
