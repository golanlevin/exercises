var myFont; 
var cellW = 64;//40;//32;//16;
var cellH = 80; //48;//40;//20; 
var nRows, nCols, nChars;
var charEditIndex; 

var letters = "Meta-design is much more difficult than design; it is easier to draw something than to explain how to draw it."; // One of the problems is that different sets of potential specifications cannot easily be envisioned all at once. Another is that a computer has to be told absolutely everything. However, once we have successfully explained how to draw something in a sufficiently general manner, the same explanation will work for related shapes, in different circumstances.";//; so the time spent in formulating a precise explanation turns out to be worth it.";

function setup() {
  createCanvas(800, 800); 
  charEditIndex = letters.length;

  myFont = textFont("Courier", 80); // A monospace font

  nRows = int(height/cellH);
  nCols = int(width/cellW);
  nChars = nRows*nCols;
  // Pad out the text to fill the whole grid. 
  if (letters.length < nChars) {
    for (var i=letters.length; i<nChars; i++) {
      letters += " ";
    }
  }
}

function draw() {
  background(253);  
  drawGrid(); 
  drawCursor(); 
  drawText();
}


//----------------------------------------------------
function drawCursor() {
  var cursorXCell = (charEditIndex%nCols); 
  var cursorYCell = Math.floor(charEditIndex/nCols); 
  fill(255, 200, 200); 

  var cursorX = cursorXCell*cellW;
  var cursorY = cursorYCell*cellH; 
  rect(cursorX, cursorY+1, cellW-1, cellH-1);
}

//----------------------------------------------------
function drawText() {
  fill(0); 
  noStroke();
  textFont(myFont, 72);
  textAlign(CENTER);
  for (var i = 0; i<letters.length; i++) {
    var c = letters.charAt(i); 
    var cx = (i%nCols)*cellW;
    print(i, c, cx);
    var cy = (1 + Math.floor(i/nCols))*cellH; 
    text(c, cx+cellW/2, cy-10);
  }
}

//----------------------------------------------------
function drawGrid() {
  strokeWeight(2);
  stroke(200); 
  for (var cy=1; cy<nRows; cy++) {
    line(0, cy*cellH+0, width, cy*cellH+0);
    line(0, cy*cellH+1, width, cy*cellH+1);
  }
  for (var cx=1; cx<nCols; cx++) {
    line(cx*cellW+0, 0, cx*cellW+0, height); 
    line(cx*cellW-1, 0, cx*cellW-1, height);
  }
}

//----------------------------------------------------
function mousePressed() {
  setEditIndexFromScreenPosition(mouseX, mouseY);
}

function mouseDragged() {
  setEditIndexFromScreenPosition(mouseX, mouseY);
}

//----------------------------------------------------
function setEditIndexFromScreenPosition(x, y) {
  var mouseXCol = Math.floor((x-2)/cellW);
  var mouseYRow = Math.floor((y-3)/cellH);
  mouseXCol = constrain(mouseXCol, 0, nCols-1); 
  mouseYRow = constrain(mouseYRow, 0, nRows-1); 
  charEditIndex = mouseYRow*nCols + mouseXCol;
}

//----------------------------------------------------
function keyPressed() {

  if (keyCode == 192) { // key == '~'
    saveFrames("word_processor","png", 1, 1);
    return; 
  } else {
    if (keyCode == 8) { // key == BACKSPACE
      charEditIndex = (charEditIndex-1+nChars)%nChars;
      let newLetters = letters.substring(0, charEditIndex);
      newLetters += ' ' + letters.substring(charEditIndex+1);
      letters = newLetters;
    } else if (keyCode == LEFT_ARROW) {
        charEditIndex = (charEditIndex-1+nChars)%nChars;
    } else if (keyCode == RIGHT_ARROW) {
        charEditIndex = (charEditIndex+1)%nChars;
    } else if (keyCode == DOWN_ARROW) {
        charEditIndex = (charEditIndex+nCols)%nChars;
    } else if (keyCode == UP_ARROW) {
        charEditIndex = (charEditIndex-nCols+nChars)%nChars;
    } else if ((keyCode >= 32) && (keyCode <= 127)) {
      let newLetters = letters.substring(0, charEditIndex);
      newLetters += key + letters.substring(charEditIndex+1);
      letters = newLetters;
      if (!mouseIsPressed) {
        charEditIndex = (charEditIndex+1)%nChars;
      }
    }
  }
}
