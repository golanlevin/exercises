# Before running, run the following on command line
#
#     $ pip install PyDictionary

from PyDictionary import PyDictionary

dictionary = None

def setup():
    size(800, 800)
    
    global dictionary
    dictionary = PyDictionary()
    
    background(253)
    
    margin = 100;
    leading = 120;
    joke = getJoke()
    print(joke)

    noLoop()
    
def draw():
    return

def getJoke():
    
    global dictionary
    nouns = "scene union computer conclusion university penalty instance leader church affair shirt revolution hat quantity efficiency candidate media restaurant intention customer perspective son village engine departure society idea knowledge manufacturer philosophy hospital news assistance communication person breath moment audience supermarket entry literature mood replacement ad statement thing meat song environment child expression procedure dirt lab inspection menu currency delivery personality effort reaction family farmer republic baseball nation explanation hearing independence wife vehicle estate police quality contribution photo profession road finding description gene stranger city president importance series basis shopping development criticism country advertising passenger alcohol teaching appearance tale negotiation fortune childhood appointment apple tooth satisfaction complaint assignment ratio phone income recipe population tradition cancer poet operation library recording sample gate agency orange dealer competition difficulty television sir wedding technology awareness heart love payment transportation drawer food singer camera argument worker truth".split()

    #picks a random word and makes sure its capitalized
    name = random.choice(nouns)
    name = name[0].upper() + name[1:] 
    
    #finds out definition
    result = dictionary.meaning(name)['Noun']
    
    #puts all definitions into one string
    answer = ''
    answer = answer + result[0] + ". "
    answer = answer[0].upper() + answer[1:] 
    # for definition in result:
    #     answer = answer + definition +". "
    
    #generates the output formatted as a knock knock joke
    output = []
    output.append("Knock knock!")
    output.append("Who's there?")
    output.append(name)
    outout.append(name + " who?")
    output.append(answer)
    
    #writes it to outputting text file
    return output
    
    
