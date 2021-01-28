//////////////////////////////////////////
// "Color Survey" (Viewer)              //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// This is the viewer, see color_survey_java for the surveyor

void setup(){
  size(512,512);
  
  String[] prompts = null; // color names will be loaded from file
  
  // load the databse. make sure you have the right folder structure
  Table db = loadTable("../color_survey_java/survey_result.csv", "header");
  if (db == null){
    println("looks like there's no databse file to view. goodbye.");
    exit();
  }
  
  int textHeight = 30;
  int columns = 5;
  float panelWidth = -1; // to be computed
  float pad = 10;
  
  // read from the database and draw the colors
  for (int i = 0; i < db.getRowCount(); i++){
    TableRow row = db.getRow(i);
    int n = row.getColumnCount();
    if (prompts == null){
      prompts = new String[n];
      for (int j = 0; j < n; j++){
        prompts[j] = row.getColumnTitle(j);
      }

      panelWidth = width/(float)prompts.length;
      for (int j = 0; j < n; j++){
        fill(255);
        stroke(0);
        rect(j*panelWidth,0,panelWidth,height);
        fill(0);
        noStroke();
        textSize(textHeight);
        text(prompts[j],j*panelWidth+pad,textHeight);
      }
    }
   
    float cellWidth = (panelWidth-pad*2)/(float)columns;
    
    int c = i % columns;
    int r = i / columns;
    
    for (int j = 0; j < n; j++){
      color hxcolor = row.getInt(prompts[j]);
      fill(red(hxcolor),green(hxcolor),blue(hxcolor));
      stroke(red(hxcolor),green(hxcolor),blue(hxcolor));
      rect(j*panelWidth+c*cellWidth+pad,textHeight+pad+r*cellWidth,cellWidth,cellWidth);
    }
  }
}
