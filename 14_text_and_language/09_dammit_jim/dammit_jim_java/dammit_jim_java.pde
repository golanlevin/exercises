String job1;
String job2;
String[] job_list;

PFont myFont;
float margin;

void setup() {
  size(800, 800);
  
  myFont = loadFont("CenturySchoolbook-60.vlw");
  textFont(myFont, 72);
  
  margin = 100;
  
  job_list = loadStrings("jobs.txt");
  reset();
}

void draw() {
  background(253);
  
  String article1 = "a";
  String article2 = "a";
  if ("aeiou".contains(job1.substring(0, 1))) {
    article1 = "an";
  }
  if ("aeiou".contains(job2.substring(0, 1))) {
    article2 = "an";
  } 
  
  String toDraw = "Dammit, Jim!\n" + "I’m " + article1 + " "+ job1 + 
                  ", not "+ article2 + " " + job2 +"!";
  
  fill(0);
  text(toDraw, margin, margin, width - 2*margin, height - 2*margin);
  
}

void reset() {
  job1 = job_list[floor(random(job_list.length))];
  job2 = "";
  while (job2 == "" || job2 == job1) {
    job2 = job_list[floor(random(job_list.length))];
  }
}

void mousePressed() {
  reset();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("dammit-jim.png");
  }
}
