myFont = None
px = 127

def setup():
  size(800, 800)
  global myFont
  myFont = createFont("FranklinGothic-Medium", 72)
  textFont(myFont)

def draw():
    background(253); 
    fill(0)
    headline ="A Crisis That Began With an Image of Police Violence Keeps Providing More"; 
    
    global px
    N = 10
    for i in range(N+1):
        g = map(i, 0, N, 255, 200)
        if (i == N):
            g = 0
        fill (g)
        tx = map(i, 0, N, 0,-127) + px
        ty = map(i, 0, N, height/4, height/2)
        text(headline, tx, ty); 
    px -= 1
    if (abs(px) > textWidth(headline)):
        px = 0

  
def keyPressed():
    if (key == ' '):
        saveFrame("scrolling_text.png")
