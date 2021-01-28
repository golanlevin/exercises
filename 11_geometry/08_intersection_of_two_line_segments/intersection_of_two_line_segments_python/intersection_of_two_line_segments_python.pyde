# Intersection point of two line segments. 

P1, P2, P3, P4 = None, None, None, None 

def setup():
  size(800, 800)
  reset()

def draw():
  background(253)

  global P1, P2, P3, P4

  # Draw the 4 points.
  noStroke()
  fill(0)
  ellipse(P1.x, P1.y, 24, 24)
  ellipse(P2.x, P2.y, 24, 24)
  ellipse(P3.x, P3.y, 24, 24)
  ellipse(P4.x, P4.y, 24, 24)

  # Draw the lines. 
  stroke(0)
  strokeWeight(8)
  line(P1.x, P1.y, P2.x, P2.y)
  line(P3.x, P3.y, P4.x, P4.y) 

  # Check if they intersect
  # Ref: http://paulbourke.net/geometry/pointlineplane/
  denominator = ((P4.y-P3.y)*(P2.x-P1.x) - (P4.x-P3.x)*(P2.y-P1.y))
  ua = ((P4.x-P3.x)*(P1.y-P3.y) - (P4.y-P3.y)*(P1.x-P3.x)) / denominator
  ub = ((P2.x-P1.x)*(P1.y-P3.y) - (P2.y-P1.y)*(P1.x-P3.x)) / denominator
  if (ua < 0 or ub < 0 or ua > 1 or ub > 1):
    # the line segments don't intersect
    pass
  else:
    # Find intersection point
    x = P1.x + ua * (P2.x-P1.x)
    y = P1.y + ua * (P2.y-P1.y)

    # Draw intersection point. 
    fill(0, 255, 0)
    ellipse(x, y, 32, 32)



def mousePressed():
  reset()

def reset():
  global P1, P2, P3, P4
  P1 = PVector(random(width), random(height))
  P2 = PVector(random(width), random(height))
  P3 = PVector(random(width), random(height))
  P4 = PVector(random(width), random(height))
