var myImage;
var myFont; 

var D = 130; 
var R = D/2; 
  
  
function preload(){
  myImage = loadImage("data/light-lamp-bulb-wire_zoom.png"); 
}
//----------------------------------------------
function setup() {
  createCanvas(800, 800);
  noLoop(); 
  
  textFont("Helvetica");
  textSize(72);
  textStyle(BOLD);
  
  
  image(myImage, 0, 0); 
  myImage.loadPixels();

  var brightestX = -1;
  var brightestY = -1; 
  var brightestBrightness = 0; 
  var myImagePixels = myImage.pixels;
  for (var y=0; y<myImage.height; y++) {
    for (var x=0; x<myImage.width; x++) {
      var index = ((y*myImage.width) + x)*4; 
      var c = myImagePixels.slice(index,index+3);
      var bri = c[0]*0.2126+c[1]*0.7151+c[2]*0.0722;
      if (bri > brightestBrightness) {
        brightestBrightness = bri; 
        brightestX = x;
        brightestY = y; 
      }
    }
  }


  drawIndicator(brightestX, brightestY, color(0,0,0)); 
  
  
  var xStr = "X: " + brightestX;
  var yStr = "Y: " + brightestY;
  noStroke();
  fill(0); 
  textAlign(RIGHT, CENTER); 
  text(yStr, brightestX-(2.666*R)-20, brightestY); 
  textAlign(CENTER, TOP); 
  text(xStr, brightestX, brightestY+(2.666*R)+20); 
}


//----------------------------------------------
function drawIndicator(cx,cy,col){
  
  noFill(); 
  stroke(col); 
  strokeWeight(10); 
  ellipseMode(CENTER); 
  ellipse(cx, cy, D, D);
  
  strokeCap(SQUARE); 
  line(cx-(R*2.666), cy, cx-R, cy); 
  line(cx-(R+40), cy-20, cx-(R+5), cy); 
  line(cx-(R+40), cy+20, cx-(R+5), cy);
  line(cx, cy+(R*2.666), cx, cy+R); 
  line(cx-20, cy+(R+40),  cx, cy+(R+5)); 
  line(cx+20, cy+(R+40),  cx, cy+(R+5)); 
}



//----------------------------------------------
function keyPressed() {
  if (key == ' ') {
    save("brightest_point.png");
  }
}











//----------------------------------------------
function drawStar (cx,cy,maxR){
  beginShape(); 
  for (var i=0; i<10; i++) {
    var t = i / 10.0 * TWO_PI + HALF_PI + radians(-10); 
    var r = (((i%2) == 0) ? 0.382*maxR:maxR);
    var px = cx + r * cos(t); 
    var py = cy + r * sin(t); 
    vertex(px, py); 
  }
  endShape(CLOSE); 
}
