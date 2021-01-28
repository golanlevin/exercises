//////////////////////////////////////////
// "Color Survey"                       //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// This is the surveyor, see color_survey_viewer_java for the viewer

String[] prompts = {"mauve","teal","plum"}; // controversial color names
float[] answers = new float[prompts.length*3]; // r,g,b,r,g,b,r,g,b
  
Table db; //database
boolean isMouseOverSubmitButton = false;

void setup(){
  size(512,512);
  
  // attempt to load database, or create it
  db = loadTable("survey_result.csv", "header");
  if (db == null){// "does not exist or could not be read"
    println("... therefore, creating that database now.");
    db = new Table();
    for (int i = 0; i < prompts.length; i++){
      db.addColumn(prompts[i]);
    }
  }

  // initialize with random colors
  for (int i = 0; i < answers.length; i++){
    answers[i] = random(1);
  }
}

// check if mouse is over a rectangular region
boolean isMouseOver(float x,float y,float w,float h){
  return (x <= mouseX && mouseX <= x+w && y <= mouseY && mouseY <= y+h);
}

// simplistic vertical slider
void slider(float[] container,int idx,float x,float y,float w,float h,color col){
  fill(50);
  stroke(0);
  rect(x,y,w,h);
  fill(col);
  float H = h*container[idx];
  rect(x,y+h-H,w,H);
  fill(255);
  stroke(0);
  rect(x-4,y+h-H-8,w+8,16);
  if (mousePressed){
    if (isMouseOver(x,y,w,h)){
      float v = 1-(mouseY-y)/h;
      container[idx] = v;
    }
  }
}

void submitButton(float x,float y,float w,float h){
  pushStyle();
  fill(255);
  stroke(0);
  if (isMouseOverSubmitButton = isMouseOver(x,y,w,h)){//not accidental
    cursor(HAND);
    fill(255,255,0);
  }else{
    cursor(ARROW);
  }
  rect(x,y,w,h);
  fill(0);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(h*0.75);
  text("Submit",x+w/2,y+h*0.42);
  popStyle();
}

void draw(){
  
  // drawing parameters
  float pad = 10;
  float pickerHeight = height-60;
  float buttonHeight = height-pickerHeight-pad*2;
  float panelWidth = width/prompts.length;
  float sliderWidth = (panelWidth-pad*4)/3;
  float textHeight = 30;
  float wellWidth = panelWidth-pad*2;
  float sliderHeight = pickerHeight-pad*4-wellWidth-textHeight;
  
  // draw the color picker
  for (int i = 0; i < prompts.length; i++){
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
  }
  
  submitButton(pad,pickerHeight+pad,width-pad*2,buttonHeight);
}

void mousePressed(){ // or mouseClicked(), which seems to have janky behaviour

  // check if user pressed the submit button
  if (isMouseOverSubmitButton){
    
    // save to database, write file, and exit
    TableRow entry = db.addRow();
    for (int i = 0; i < prompts.length; i++){
      int hexcolor = ((int)(answers[i*3  ]*255)<<16)| 
                     ((int)(answers[i*3+1]*255)<<8 )|
                     ((int)(answers[i*3+2]*255)    );
      entry.setInt(prompts[i],hexcolor);
    }
    saveTable(db,"survey_result.csv");
    String thanks = "Thank you. Your entry has been recorded.";
    println(thanks);
    // or with dialog box:
    // javax.swing.JOptionPane.showMessageDialog(null, thanks);
    exit();
  }
}
