#Exercises: Color
#Overlapping Color

def setup():
  size(800, 800)
  background(253)
  noStroke()
  blendMode(DIFFERENCE)
  
  #colored circles
  alp = 255
  a = width/3
  d = a*1.618
  h = a * sqrt(3.0) / 2.0
  m = (height - (a*2+h))/2

  # colored circles
  fill(0, 255, 0, alp)
  ellipse(a*1, m+a, d, d)

  fill(255, 0, 0, alp)
  ellipse(a*2, m+a, d, d)

  fill(0, 0, 255, alp)
  ellipse(width/2, m+a+h, d, d)
