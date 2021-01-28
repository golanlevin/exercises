########################################
# "Color Survey" (Viewer)              #
# Exercise on page 156 of CCM          #
# demo code by Lingdong Huang          #
########################################

# This is the viewer, see color_survey_py for the surveyor

def setup():
  size(512,512);
  
  prompts = None; # color names will be loaded from file
  
  # load the databse. make sure you have the right folder structure
  db = loadTable("../color_survey_java/survey_result.csv", "header");
  if (db == None):
    println("looks like there's no databse file to view. goodbye.");
    exit();
  
  textHeight = 30;
  columns = 5;
  panelWidth = -1; # to be computed
  pad = 10;
  
  # read from the database and draw the colors
  for i in range(db.getRowCount()):
    row = db.getRow(i);
    n = row.getColumnCount();
    if (prompts == None):
      prompts = [""]*n;
      for j in range(n):
        prompts[j] = row.getColumnTitle(j);

      panelWidth = width/float(len(prompts));
      for j in range(n):
        fill(255);
        stroke(0);
        rect(j*panelWidth,0,panelWidth,height);
        fill(0);
        noStroke();
        textSize(textHeight);
        text(prompts[j],j*panelWidth+pad,textHeight);
      
    cellWidth = (panelWidth-pad*2)/float(columns);
    
    c = i % columns;
    r = i / columns;
    
    for j in range(n):
      hxcolor = row.getInt(prompts[j]);
      fill(red(hxcolor),green(hxcolor),blue(hxcolor));
      stroke(red(hxcolor),green(hxcolor),blue(hxcolor));
      rect(j*panelWidth+c*cellWidth+pad,textHeight+pad+r*cellWidth,cellWidth,cellWidth);
