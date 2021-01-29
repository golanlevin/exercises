var myFont;
var myImage;

var grays10 = "@%#*+=-:. ";
var grays58 = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft1?+-~i!lI;:,\"^`. ";

var photo;

function preload() {
  myImage = loadImage("data/muriel_cooper.jpg");
}

function setup() {
  createCanvas(800, 800); 
  //noLoop();

  myFont = textFont("Courier-Bold", 32);
}


function draw() {
  background(253); 
  textAlign(LEFT, BASELINE); 
  textFont(myFont, 40);
  fill(0, 0, 0); 

  var grays = grays58;
  var nGrays = grays58.length;

  var charW = 25; 
  var charH = 32; 
  var nCharX = width/charW; 
  var nCharY = height/charH; 

  for (var ty = 0; ty<nCharY; ty++) {
    for (var tx = 0; tx<nCharX; tx++) {

      var px = Math.round((tx + 0.5)*charW); 
      var py = Math.round((ty + 0.5)*charH);
      var pixelColor = myImage.get(px, py); 
      var pixelGray = brightness(pixelColor); // value range is (0, 100)
      
      var grayLevel = Math.round(map(pixelGray, 0, 100, 0, nGrays-1)); 
      var grayChar = grays.charAt(grayLevel); 
      text(grayChar, tx*charW+1, ty*charH + 30);
    }
  }
}

function keyTyped() {
  if (key === 's') {
    saveFrames('ascii_vision', 'png', 1, 1);
  }
}
