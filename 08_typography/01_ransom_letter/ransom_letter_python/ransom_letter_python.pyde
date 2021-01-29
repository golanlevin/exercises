myFonts = None

def setup():
    size(800, 800)
    
    global myFonts 
    myFonts = [None] * 3   
    myFonts[0] = createFont("Times-Bold", 80)
    myFonts[1] = createFont("Courier-Bold", 80)
    myFonts[2] = createFont("Helvetica-Bold", 80)
    noLoop()
    
def draw():
    background(253)
    
    phrase = "STEAL\nTHIS\nBOOK"
    nChars = len(phrase)
    
    fill(0)
    
    xinit = 120
    tx = xinit
    ty = 120
    
    textAlign(LEFT, TOP);
    
    for i in range(nChars):
        ithChar = phrase[i]
        if (ithChar == '\n'):
            ty += 200
            tx = xinit
        else:
            r = floor(random(2.0000))
            global myFonts
            textFont(myFonts[r], random(120, 220))
            text(ithChar, tx, ty)
            tx += textWidth(ithChar)

def keyPressed():
    saveFrame("ransom_letter.png")
    
    
