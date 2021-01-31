import java.time.YearMonth; 

void setup() {
  size(800, 800, FX2D);
  noLoop(); 
}


void draw() {
  rectMode(CENTER);
  ellipseMode(CENTER); 
  background(253);
  noStroke();
  smooth();
  

  // Using Java8, You can fetch the number of days in the current month. 
  // Beginners could hardcode numberOfDaysInMonth if necessary.
  YearMonth yearMonthObject = YearMonth.of (year(), month());
  int numberOfDaysInMonth = yearMonthObject.lengthOfMonth(); // e.g. 31
  int D = day(); 

  // Remember that days are usually counted from 1, not 0.
  for (int d=1; d<=numberOfDaysInMonth; d++) {
    float dayX = map(d,0,numberOfDaysInMonth+1, 0,width); 
    
    //draws a circle for the current day
    if (d == D) {
      fill(250, 100, 100);
      // ellipse(dayX, height/2 - 20, 25, 25);
      
      float dw = 8;
      float dh = 100;
      float dl = dayX-dw;
      float dr = dayX+dw;
      float db = height/2 + dh; 
      float dt = height/2 - dh; 
      triangle(dl,dt, dr,dt, dayX,db);
      
     //draws a bar representing all the other days
    } else {
      fill(0);
      //rect(dayX, height/2, 6, 100);
      
      
      float dw = 5;
      float dh = 100;
      float dl = dayX-dw;
      float dr = dayX+dw;
      float db = height/2 + dh/2; 
      float dt = height/2 - dh/2; 
      triangle(dl,db, dr,db, dayX,dt); 
      
    }
  }
}

void keyPressed() {
  save("../mini_calendar.png");
}
