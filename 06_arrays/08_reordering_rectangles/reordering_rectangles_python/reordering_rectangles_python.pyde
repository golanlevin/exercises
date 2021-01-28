colors = [color(191, 241, 255), 
          color(236, 213, 162), 
          color(223, 255, 191), 
          color(255, 227, 254)]
offset, ssize, factor, rectList = 0, 0, 0, []


def setup():
    size(800, 800)
    
    global offset, ssize, factor, rectList
    
    offset = 50
    ssize = (width - 3*offset)/2
    factor = ssize/10
    r1 = Rectangle(0, 4, 5, 4, colors[0])
    r2 = Rectangle(4, 3, 4, 3, colors[1])
    r3 = Rectangle(2, 1, 4, 4, colors[2])
    r4 = Rectangle(1, 0, 6, 2, colors[3])
  
    rectList.append(r1)
    rectList.append(r2)
    rectList.append(r3)
    rectList.append(r4)

def draw():
    
    offset = 70
  
    background(253)
    stroke(0)
    strokeWeight(2)
    
    for x in range(5, width-10, 20):
        line(x,height/2, x+10, height/2) 
    
    for y in range(5, height-10, 20):
        line(width/2, y, width/2, y+10)
    
    stroke(0)
    strokeWeight(8)
    strokeJoin(MITER)
    
    # normal order
    pushMatrix()
    translate(offset, offset)
    for i in range(4):
        r = rectList[i]
        fill(r.c)
        rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h)
    popMatrix()
    
    # reverse order
    pushMatrix()
    translate(offset*2 + ssize, offset)
    for i in range(3, -1, -1):
        r = rectList[i]
        fill(r.c)
        rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h)
    popMatrix()
    
    # sort by area
    sortedByArea = sorted(rectList, key = lambda r: r.getArea())
    pushMatrix()
    translate(offset, ssize + 2*offset)
    for i in range(3, -1, -1):
        r = sortedByArea[i]
        fill(r.c)
        rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h)
    popMatrix()
    
    # sort by left side
    sortedByLeftSide = sorted(rectList, key = lambda r: r.getLeft())
    pushMatrix()
    translate(ssize + 2*offset, ssize + 2*offset)
    for i in range(3, -1, -1):
        r = sortedByLeftSide[i]
        fill(r.c)
        rect(factor*r.x, factor*r.y, factor*r.w, factor*r.h)
    popMatrix()
  

class Rectangle:
    def __init__(self, xx, yy, ww, hh, cc):
        self.x = xx
        self.y = yy
        self.w = ww
        self.h = hh
        self.c = cc

    def getArea(self):
        return self.w*self.h
    
    def getLeft(self):
        return self.x
    
    
