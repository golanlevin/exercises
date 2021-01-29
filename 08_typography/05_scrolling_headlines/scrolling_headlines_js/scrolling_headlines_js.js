var myFont; 
var px = 127; 

function setup() {
  createCanvas(800, 800);
  myFont = "FranklinGothic-Medium"; 
  textFont(myFont, 72); 
}

function draw() {
  background(253); 
  fill(0);
  var headline ="A Crisis That Began With an Image of Police Violence Keeps Providing More"; 
  
  var N = 10; 
  for (var i=0; i<=N; i++){
    var g = map(i, 0, N, 255, 200); 
    if (i == N) { g = 0; }
    fill (g);
    var tx = map(i, 0, N, 0,-127) + px; 
    var ty = map(i, 0, N, height/4, height/2); 
    text(headline, tx, ty); 
  }
  px--; 
  if (abs(px) > textWidth(headline)){
    px = 0; 
  }
}

function keyTyped() {
  if (keyCode == 32) {
    saveFrames('scrolling_text', 'png', 1, 1);
  }
}
