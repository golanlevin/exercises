PFont myFont; 
int cellW = 64;//40;//32;//16;
int cellH = 80;//48;//40;//20; 
int nRows, nCols, nChars;
int charEditIndex; 

String letters = "Meta-design is much more difficult than design; it is easier to draw something than to explain how to draw it."; // One of the problems is that different sets of potential specifications cannot easily be envisioned all at once. Another is that a computer has to be told absolutely everything. However, once we have successfully explained how to draw something in a sufficiently general manner, the same explanation will work for related shapes, in different circumstances.";//; so the time spent in formulating a precise explanation turns out to be worth it.";

void setup() {
  size(800, 800); 
  charEditIndex = letters.length();

  myFont = createFont("pixelmix", 80); // A monospace font
  textFont(myFont);

  nRows = height/cellH;
  nCols = width/ cellW;
  nChars = nRows*nCols;
  // Pad out the text to fill the whole grid. 
  if (letters.length() < nChars) {
    for (int i=letters.length(); i<nChars; i++) {
      letters += " ";
    }
  }
}

void draw() {
  background(253);  
  drawGrid(); 
  drawCursor(); 
  drawText();
}


//----------------------------------------------------
void drawCursor() {
  int cursorXCell = (charEditIndex%nCols); 
  int cursorYCell = (charEditIndex/nCols); 
  fill(255, 200, 200); 

  int cursorX = cursorXCell*cellW;
  int cursorY = cursorYCell*cellH; 
  rect(cursorX, cursorY+1, cellW-1, cellH-1);
}

//----------------------------------------------------
void drawText() {
  fill(0); 
  textFont(myFont, 80);
  textAlign(CENTER);
  for (int i=0; i<letters.length(); i++) {
    char c = letters.charAt(i); 
    int cx = (i%nCols)*cellW;
    int cy = (1 + (i/nCols))*cellH; 
    text(c, cx+cellW/2, cy-5);
  }
}

//----------------------------------------------------
void drawGrid() {
  strokeWeight(2);
  stroke(200); 
  for (int cy=1; cy<nRows; cy++) {
    line(0, cy*cellH+0, width, cy*cellH+0);
    line(0, cy*cellH+1, width, cy*cellH+1);
  }
  for (int cx=1; cx<nCols; cx++) {
    line(cx*cellW+0, 0, cx*cellW+0, height); 
    line(cx*cellW-1, 0, cx*cellW-1, height);
  }
}

//----------------------------------------------------
void mousePressed() {
  setEditIndexFromScreenPosition(mouseX, mouseY);
}

void mouseDragged() {
  setEditIndexFromScreenPosition(mouseX, mouseY);
}

//----------------------------------------------------
void setEditIndexFromScreenPosition(int x, int y) {
  int mouseXCol = (x-2)/cellW;
  int mouseYRow = (y-3)/cellH; 
  mouseXCol = constrain(mouseXCol, 0, nCols-1); 
  mouseYRow = constrain(mouseYRow, 0, nRows-1); 
  charEditIndex = mouseYRow*nCols + mouseXCol;
}

//----------------------------------------------------
void keyPressed() {

  if (key == '~') {
    saveFrame("word_processor.png");
    return; 
  } else {
    if (key == BACKSPACE) {
      charEditIndex = (charEditIndex-1+nChars)%nChars;
      String newLetters = letters.substring(0, charEditIndex);
      newLetters += ' ' + letters.substring(charEditIndex+1);
      letters = newLetters;
    } else if (key == CODED) {
      if (keyCode == LEFT) {
        charEditIndex = (charEditIndex-1+nChars)%nChars;
      } else if (keyCode == RIGHT) {
        charEditIndex = (charEditIndex+1)%nChars;
      } else if (keyCode == DOWN) {
        charEditIndex = (charEditIndex+nCols)%nChars;
      } else if (keyCode == UP) {
        charEditIndex = (charEditIndex-nCols+nChars)%nChars;
      }
    } else if ((key >= 32) && (key <= 127)) {
      String newLetters = letters.substring(0, charEditIndex);
      newLetters += key + letters.substring(charEditIndex+1);
      letters = newLetters;
      if (!mousePressed) {
        charEditIndex = (charEditIndex+1)%nChars;
      }
    }
  }
}
