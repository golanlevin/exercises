// Exercises: Arrays
// Longest Line
//
// Drag the mouse to draw lines. The longest line will be red.

PImage cursorImg;
float longestLength = 0;
//-------------------------------------------
ArrayList<LineSegment> lines; 
class LineSegment {
  PVector p1; 
  PVector p2; 
  LineSegment() {
    p1 = new PVector(); 
    p2 = new PVector();
  }
  void draw() {
    line(p1.x, p1.y, p2.x, p2.y);
  }
  float length() {
    return dist(p1.x, p1.y, p2.x, p2.y);
  }
}

//-------------------------------------------
void setup() {
  size(800, 800, FX2D);
  lines = new ArrayList<LineSegment>(); 
  cursorImg = loadImage("cursor_with_shadow_15x21.png");
}

//-------------------------------------------
void draw() {
  background(253);

  // Determine which line is longest.
  float currentLongestLength = 0; 
  int indexOfCurrentLongest = -1;
  for (int i = 0; i < lines.size(); i++) {
    LineSegment aLine = lines.get(i); 
    if (aLine.length() > currentLongestLength) {
      currentLongestLength = aLine.length(); 
      indexOfCurrentLongest = i;
    }
  }
  longestLength = currentLongestLength;


  // Draw all of the lines
  strokeCap(SQUARE); 
  stroke(0);
  strokeWeight(8);
  for (int i = 0; i < lines.size(); i++) {
    LineSegment aLine = lines.get(i); 
    if (i != indexOfCurrentLongest) {
      aLine.draw();
    }
  }

  if (indexOfCurrentLongest >= 0) {
    LineSegment aLine = lines.get(indexOfCurrentLongest); 
    stroke(255, 50, 50);
    strokeWeight(17);
    aLine.draw();
  }

  image(cursorImg, mouseX, mouseY, 15*6, 21*6);
}

//-------------------------------------------
// Add beginning and end points of mouse drag to x and y arrays
void mousePressed() {
  lines.add(new LineSegment()); 
  lines.get(lines.size()-1).p1.set(mouseX, mouseY); 
  lines.get(lines.size()-1).p2.set(mouseX, mouseY);
}

//-------------------------------------------
void mouseDragged() {  
  lines.get(lines.size()-1).p2.set(mouseX, mouseY);
}

//-------------------------------------------
void mouseReleased() {
  lines.get(lines.size()-1).p2.set(mouseX, mouseY);
}

//-------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("longest_line.png");
  } else if (key == 'Z') {
    if (lines.size() > 0) {
      lines.remove(lines.size()-1);
    }
  } else {
    lines.clear();
  }
}
