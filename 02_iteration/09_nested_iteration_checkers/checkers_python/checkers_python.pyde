def setup() :
  size(800, 800)

def draw():
  n = 8
  s = height/n

  a = 1
  #color of each individual square
  c = 0
  #the board is 8 by 8
  for i in range (0, n):
    x = i*s
    #alternates fill between black and white
    a=a*-1
    for j in range (0, n):
      y = j*s
      #alternates fill between black and white
      a=a*-1
      if (a<0):
        #changes fill to black
        c=0
      if (a>0):
        #changes fill to white
        c=255
      fill(c)
      #draws individual checkers squares
      rect(x, y, s, s)
