

  


def shuffle(array):
    currentIndex = len(array)

    #While there remain elements to shuffle...
    while (0 != currentIndex):

        #Pick a remaining element...
        randomIndex = int(random(currentIndex))
        currentIndex = currentIndex-1

        #And swap it with the current element.
        temporaryValue = array[currentIndex]
        array[currentIndex] = array[randomIndex]
        array[randomIndex] = temporaryValue
        

    return array



def setup():
    size(600,600)
    background(255)
    global lines 
    global y
    y=34
    lines = loadStrings("frost.txt")
    print("there are %i lines" % len(lines))
    shuffle(lines)
    f = createFont("Times", 34)
    background(255)
    textFont(f)            
    fill(0) 
    
    
    for line in lines:
        print(line)
        text(line,10,y)
        y=y+36

def draw():
    shuffle(lines)
    
def mousePressed():
    saveFrame()
 

