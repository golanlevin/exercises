# See Paul Bourke, "Character representation of grey scale images", 
# http://paulbourke.net/dataformats/asciiart/

# two different options of common character ramps for representing levels of grey
grays10 = "@%#*+=-:. "
grays58 = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft1?+-~i!lI;:,\"^`. "
myFont = None
myImage = None

def setup():
    size(800, 800)
    global myFont
    myFont = createFont("Courier-Bold", 32)
    global myImage
    myImage = loadImage("muriel_cooper.jpg")
    textFont(myFont, 40)

def draw():
    background(253)
    textAlign(LEFT, BASELINE)
    # textFont(myFont, 40)
    fill(0, 0, 0)
    
    grays = grays58
    nGrays = len(grays)
    
    charW = 25
    charH = 32
    nCharX = int(width/charW)
    nCharY = int(height/charH)
        
    for ty in range(nCharY):
        for tx in range(nCharX):
            px = int((tx + 0.5)*charW)
            py = int((ty + 0.5)*charH)
            pixelColor = myImage.get(px, py)
            pixelGray = brightness(pixelColor)
            
            grayLevel = int(map(pixelGray, 0, 255, 0, nGrays-1))
            grayChar = grays[grayLevel]
            text(grayChar, tx*charW+1, ty*charH + 30)

def keyPressed():
    if (key == ' '):
        saveFrame("ascii_vision.png")
