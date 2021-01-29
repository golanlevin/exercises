// split_flap_type_java
// It helps to use a monospace font for this.

var myFont;  

var nLetters; 
var startWord = ['B', 'A', 'R']; 
var endWord   = ['H', 'E', 'N'];
var currentWord;
var textY; 
var textX; 

//----------------------------------------
function setup() {
  createCanvas(800, 800); 
  frameRate(10); 

  myFont = textFont("Helvetica-Bold", 72);
  textY = 100;
  textX = 88; 
  
  nLetters = startWord.length; 
  currentWord = []; 
  for (var i=0; i<nLetters; i++) {
    currentWord.push(startWord[i]);
  }
  background(253); 
}

//----------------------------------------
function draw() {

  // render the current word. 
  // as the word changes, move it downwards.
  drawCurrentWord(textX, textY); 
  
  // render the current word large, 
  // in the same spot
  push(); 
  translate(width/2, height/2); 
  scale(2,2); 
  drawCurrentWord(0,0); 
  pop(); 
  
  //-------------------------
  // update the current word
  var bChanged = false;
  for (var i=0; i<nLetters; i++) {
    if ((currentWord[i]).charCodeAt(0) < (endWord[i]).charCodeAt(0)) {
      currentWord[i] = String.fromCharCode((currentWord[i]).charCodeAt(0) + 1);
      bChanged = true;
    } else if ((currentWord[i]).charCodeAt(0) > (endWord[i]).charCodeAt(0)) {
      currentWord[i] = String.fromCharCode((currentWord[i]).charCodeAt(0) - 1);
      bChanged = true;
    }
  }
  if (bChanged){
    textY += 100; 
    fill(253, 60); 
    rectMode(CORNER);
    rect(0,0,width, height); 
  }
}


//----------------------------------------
function drawCurrentWord(tx, ty){
  textFont(myFont, 44*2); 
  textAlign(CENTER, CENTER); 
  rectMode(CENTER); 
  var boxSpacing = 36*2; 
  var boxWidth = boxSpacing-4;
  var boxHeight = 46*2; 
  var textOffsetY = 4;
  push(); 
  translate(tx, ty); 
  for (var i=0; i<nLetters; i++) {
    var px = i*boxSpacing; 
    var py = 0;
    noStroke(); 
    fill(0, 0, 0); 
    rect(px, py, boxWidth, boxHeight); 
    fill(255); 
    text(currentWord[i], px-1, py+textOffsetY);
  }
  pop(); 
}



//----------------------------------------
function keyTyped() {
  if (keyCode == 32) { // empty space
    saveFrames('split_flap_type', 'png', 1, 1);
  }
}
