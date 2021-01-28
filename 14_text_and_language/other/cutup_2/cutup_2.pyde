

  


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
    global lines2
    global y
    y=19
    lines = loadStrings("trump.txt")
    lines2 = loadStrings("macbeth.txt")
    lines3 = lines + lines2
    print("there are %i lines" % len(lines))
    shuffle(lines3)

    f = createFont("Times", 18)
    background(255)
    textFont(f)            
    fill(0) 
    
    
    for line in lines3:
        print(line)
        text(line,5,y)
        y=y+18

def draw():
    shuffle(lines)
    
    
def mousePressed():
    saveFrame()
 

