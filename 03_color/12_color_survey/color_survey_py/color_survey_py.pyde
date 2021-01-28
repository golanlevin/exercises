########################################
# "Color Survey"                       #
# Exercise on page 156 of CCM          #
# demo code by Lingdong Huang          #
########################################

# This is the surveyor, see color_survey_viewer_py for the viewer

prompts = ["mauve","teal","plum"]; # controversial color names
answers = [random(1) for _ in range(len(prompts)*3)]; # r,g,b,r,g,b,r,g,b
  
db = None; #database
isMouseOverSubmitButton = False;

def setup():
  global db
  size(512,512);

  # attempt to load database, or create it
  db = loadTable("survey_result.csv", "header");

  if (db == None):# "does not exist or could not be read"
    println("... therefore, creating that database now.");
    db = __builtin__.Table(); # looks like processing.py has problem exposing Table(), ew
    for p in prompts:
      db.addColumn(p);

# check if mouse is over a rectangular region
def isMouseOver(x,y,w,h):
  return (x <= mouseX and mouseX <= x+w and y <= mouseY and mouseY <= y+h);

# simplistic vertical slider
def slider(container,idx,x,y,w,h,col):
  fill(50);
  stroke(0);
  rect(x,y,w,h);
  fill(col);
  H = h*container[idx];
  rect(x,y+h-H,w,H);
  fill(255);
  stroke(0);
  rect(x-4,y+h-H-8,w+8,16);
  if (mousePressed):
    if (isMouseOver(x,y,w,h)):
      v = 1-(mouseY-y)/float(h);
      container[idx] = v;

def submitButton(x,y,w,h):
  global isMouseOverSubmitButton;
  pushStyle();
  fill(255);
  stroke(0);
  isMouseOverSubmitButton = isMouseOver(x,y,w,h)
  if isMouseOverSubmitButton:
    cursor(HAND);
    fill(255,255,0);
  else:
    cursor(ARROW);
  rect(x,y,w,h);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(h*0.75);
  text("Submit",x+w/2,y+h*0.42);
  popStyle();

def draw():
  
  # drawing parameters
  pad = 10;
  pickerHeight = height-60;
  buttonHeight = height-pickerHeight-pad*2;
  panelWidth = width/len(prompts);
  sliderWidth = (panelWidth-pad*4)/3;
  textHeight = 30;
  wellWidth = panelWidth-pad*2;
  sliderHeight = pickerHeight-pad*4-wellWidth-textHeight;
  
  # draw the color picker
  for i in range(len(prompts)):
    pushMatrix();
    fill(255);
    stroke(0);
    rect(i*panelWidth,0,panelWidth,pickerHeight);
    fill(answers[i*3]*255,answers[i*3+1]*255,answers[i*3+2]*255);
    rect(i*panelWidth+pad,pad*2+textHeight,wellWidth,wellWidth);
    
    slider(answers,i*3+0,i*panelWidth+pad,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(255,0,0));
    slider(answers,i*3+1,i*panelWidth+pad+sliderWidth+pad,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(0,255,0));
    slider(answers,i*3+2,i*panelWidth+pad+(sliderWidth+pad)*2,pad*3+textHeight+wellWidth,sliderWidth,sliderHeight,color(0,0,255));

    fill(0);
    noStroke();
    textSize(textHeight);
    text(prompts[i],i*panelWidth+pad,pad+textHeight);
    popMatrix();
  
  submitButton(pad,pickerHeight+pad,width-pad*2,buttonHeight);


def mousePressed(): # or mouseClicked(), which seems to have janky behaviour
  
  # check if user pressed the submit button
  if (isMouseOverSubmitButton):
    
    # save to database, write file, and exit
    entry = db.addRow();
    for i in range(len(prompts)):
      hexcolor = (int(answers[i*3  ]*255)<<16)| \
                 (int(answers[i*3+1]*255)<<8 )| \
                 (int(answers[i*3+2]*255)    );
      entry.setInt(prompts[i],hexcolor);
    
    saveTable(db,"survey_result.csv");
    thanks = "Thank you. Your entry has been recorded.";
    println(thanks);

    exit();
