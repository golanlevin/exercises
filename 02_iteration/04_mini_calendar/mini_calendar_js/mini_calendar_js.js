function setup() {
  createCanvas(800, 800);
  noLoop(); 
}


function draw() {
  rectMode(CENTER);
  ellipseMode(CENTER); 
  background(253);
  noStroke();
  smooth();

  var numberOfDaysInMonth = lengthOfMonth();
  var D = day(); 

  // Remember that days are usually counted from 1, not 0.
  for (var d=1; d<=numberOfDaysInMonth; d++) {
    var dayX = map(d,0,numberOfDaysInMonth+1, 0, width); 
    
    //draws a circle for the current day
    if (d == D) {
      fill(250, 100, 100);
      // ellipse(dayX, height/2 - 20, 25, 25);
      
      var dw = 8;
      var dh = 100;
      var dl = dayX-dw;
      var dr = dayX+dw;
      var db = height/2 + dh; 
      var dt = height/2 - dh; 
      triangle(dl,dt, dr,dt, dayX,db);
      
     //draws a bar representing all the other days
    } else {
      fill(0);
      
      var dw = 5;
      var dh = 100;
      var dl = dayX-dw;
      var dr = dayX+dw;
      var db = height/2 + dh/2; 
      var dt = height/2 - dh/2; 
      triangle(dl,db, dr,db, dayX,dt); 
      
    }
  }
}

function lengthOfMonth(){
    m = month()
    //hardcoded function tells how many days in a given month
    if(m==1 || m==3  ||  m==5  ||  m==7  ||  m==8  ||  m==10  ||  m==31){
        return 31;
    } else if (m ==4  ||  m==6  ||  m==9  ||  m==11){
        return 30;
    } else {
        if (year()%4 === 0){
            return 29;  //leapyear
        }
        return 28;
    }
}
