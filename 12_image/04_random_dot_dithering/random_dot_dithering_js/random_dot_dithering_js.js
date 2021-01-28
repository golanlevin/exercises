var img;

function preload(){
  img = loadImage("data/lillian_schwartz.jpg");//grace_hopper_3.png");
  

}

function setup() {
  createCanvas(800, 800);
  background(253);
  fill(0);
  noStroke();
  img.loadPixels();
}

function draw() {

  var dotsPerFrame = 20; 
  
  stroke(0); 
  strokeWeight(4.5); 
  strokeCap(ROUND); 

  for (var i=0; i<dotsPerFrame; i++){
    var x = ~~(random(img.width));
    var y = ~~(random(img.height));
    b = 0.2126*img.pixels[(y*img.width+x)*4] + 0.7152*img.pixels[(y*img.width+x)*4+1] + 0.0722*img.pixels[(y*img.width+x)*4+2];
    b = 255.0 * pow((b/255.0), 0.75);
    
    if (random(255) > b) {
      var xx = map(x, 0, img.width, 0, width);
      var yy = map(y, 0, img.height, 0, height);
      point(xx,yy); 
    }
  }
}

function keyPressed() {
  if (key == ' ') {
    save("random_dot_dithering-####.png");
  }
}
