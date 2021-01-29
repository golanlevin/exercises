// Exercises: Arrays
// Animated walk cycle

var frames = []; //array for image frames
var f = 0;

function setup() {
  frameRate(15); 
  background(0);
  createCanvas(800, 800);
  
  //load frames into the array
  for (var i=0; i < 15; i++) {
    var ii = nf(i, 2);
    frames[i] = loadImage("data/frame_" + ii + ".png");
  }
  
}

function draw() {
  background(253);
  
  var img = frames[f];
  image(img, 0, 100, img.width * 8/3, img.height * 8/3);
  
  if (f<frames.length-1) { 
    f++; //increase frame variable
  } else {
    f=0;
  }
}
