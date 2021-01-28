# Exercises: Array
# Plant the Flag

# A bumpy "landscape" or terrain, 
# consisting of an array of height values, 
# has been provided to you. 
# Write code which searches through this array, 
# and draws "flags" on the peaks (i.e. local maxima).

terrain = []

def placeFlagsOnTerrain():
  # PLACE YOUR CODE HERE TO DETECT HILLS
  
  for i in range(2, width-2):
    yZ = terrain[i - 2] 
    yA = terrain[i - 1] 
    yB = terrain[i + 0]
    yC = terrain[i + 1]
    yD = terrain[i + 2]

    if ((yA > yB) and (yC > yB) and (yD > yB) and (yZ > yB)): 
      drawFlag(i, yB) # We found a peak... draw a flag!

def drawFlag (flagx, flagy):
  # For example...
  stroke(0)
  strokeWeight(2)
  line(flagx, flagy, flagx, flagy - 160)
  rect(flagx, flagy-160, 66, 40)

#----------------------------------------------------------------------
# There should be no reason for you to modify any code below this line: 
def setup():
  size(800, 800)
  global terrain
  terrain = [0]*width

def draw():
  background(253)
    
  skyColor = color(200,230,255)
  for y in range(height): 
    t = map(y, 0, height, 0, 1)
    t = pow(t, 0.25)
    a = map(t, 0,1, 255, 0)
    stroke(skyColor, a)
    line(0,y, width, y)
  
  
  calculateTerrain()
  renderTerrain()
  placeFlagsOnTerrain()

def calculateTerrain():
  noiseDetail(2, 0.1)
  noiseSeed(12345)
  for i in range(width):
    val = noise(i/100.0 + frameCount/50.0)
    y = map(val, 0, 1, height*0.25, height*0.98)
    global terrain
    terrain[i] = y

def renderTerrain():
  stroke(0)
  for i in range(width):
      global terrain
      y = terrain[i] 
      line(i, height, i, y)
