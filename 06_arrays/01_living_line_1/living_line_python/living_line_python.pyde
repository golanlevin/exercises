# Exercises: Arrays
# Living Line 1
#
# Move the mouse and a line will follow.

nPoints = 100
xPos = [0] * nPoints
yPos = [0] * nPoints

def setup():
    size(800, 800)
    
def draw():
    background(253)
    stroke(0)
    strokeWeight(8)
    
    xPos[nPoints-1] = mouseX
    yPos[nPoints-1] = mouseY
    
    for i in range(nPoints-1):
        line(xPos[i], yPos[i], xPos[i+1], yPos[i+1])
        xPos[i] = xPos[i+1]
        yPos[i] = yPos[i+1]
        
