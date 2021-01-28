# Exercises: Arrays
# Longest Line
#
# Drag the mouse to draw lines. The longest line will be red.

xpos1 = []
ypos1 = []
xpos2 = []
ypos2 = []

longestLength = 0
indexOfLongest = 0

def setup():
  size(800, 800)

def draw():
  background(253)

  # Determine which line is longest.
  for i in range(len(xpos2)): 
    global longestLength
    global indexOfLongest
    if (dist(xpos1[i], ypos1[i], xpos2[i], ypos2[i]) > longestLength):
      longestLength = dist(xpos1[i], ypos1[i], xpos2[i], ypos2[i])
      indexOfLongest = i

  # Draw all of the lines
  for i in range(len(xpos2)):
    global indexOfLongest
    if (i == indexOfLongest): 
        # Longest line is thick and red
        stroke(255, 50, 50)
        strokeWeight(17)
    else:
        # All other stored lines are thin and black
        stroke(0)
        strokeWeight(8)
            
    line(xpos1[i], ypos1[i], xpos2[i], ypos2[i])
        

# Add beginning and end points of mouse drag to x and y arrays
def mousePressed():
  xpos1.append(mouseX)
  ypos1.append(mouseY)

def mouseReleased():
  xpos2.append(mouseX)
  ypos2.append(mouseY)

# Draw line as it's being dragged
def mouseDragged():
    stroke(200)
    strokeWeight(8)
    line(mouseX, mouseY, xpos1[len(xpos1) - 1], ypos1[len(xpos1) - 1])
