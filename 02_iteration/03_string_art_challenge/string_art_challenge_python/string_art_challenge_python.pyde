def setup():
    size(800, 800)
    smooth()


def draw():
    background(253)
    strokeWeight(8)
    stroke(0)
    strokeCap(SQUARE)

    # sets amount of lines being drawn
    nLines = 8
    # sets margin
    margin = 50

    for i in range(0, nLines):
        # line always starts with the same x value
        x0 = margin
            # line always ends with the same y value
        y1 = height - margin
            # makes the lines starting y values equidistant
        y0 = map(i, 0, nLines - 1, margin, height - margin)
        x1 = y0
        line(x0, y0, x1, y1)
