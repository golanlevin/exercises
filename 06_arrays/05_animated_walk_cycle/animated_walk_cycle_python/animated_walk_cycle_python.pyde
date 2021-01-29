# Exercises: Arrays
# Animated walk cycle
#
# Frame by frame horse animation.

frames = [0] * 15
f = 0

def setup():
    frameRate(15)
    background(0)
    size(800, 800)
    
    # load frames into the array
    for i in range(len(frames)):
        ii = nf(i, 2)
        frames[i] = loadImage("frame_"+ii+".png")
        
def draw():
    global f
    image(frames[f], 0, 100, frames[f].width*8/3, frames[f].height*8/3)
    
    if (f < len(frames)-1):
        f += 1
    else:
        f = 0
