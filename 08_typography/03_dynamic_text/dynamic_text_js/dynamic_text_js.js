// Dynamic Text (text over time): GROW

var tSize;
var tPos; 

//----------------------------------------
function setup() {
  createCanvas(800, 800); 

  background(253);
  tSize = 10;
  tPos = height * 0.8;
}

//----------------------------------------
function draw() {
  if (frameCount < 50) {
    tSize *= 1.05;
    tPos = tPos - 6.0;

    noStroke(); 
    fill(255, 255, 255, 20); 
    rect(0, 0, width, height); 

    textFont("Georgia", tSize); 
    textAlign(CENTER); 
    fill(0);
    print(tSize);
    drawWord();
    
  } else if (frameCount == 50) {
    fill(255);
    textFont("Georgia", tSize); 
    textAlign(CENTER); 
    text("GROW", 400, tPos);
    noLoop();
  }
}

//----------------------------------------
function drawWord() {
  var step = 4;
  for (var dy=-step; dy<=step; dy+=step) {
    for (var dx=-step; dx<=step; dx+=step) {
      textSize(tSize);
      text("GROW", width/2-dx, tPos+dy);
    }
  }
}

function keyTyped() {
  if (key === 's') {
    saveFrames('text_with_feeling', 'png', 1, 1);
  }
}
