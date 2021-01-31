def setup():
  size(800, 800)
    
def draw():
  rectMode(CENTER)
  ellipseMode(CENTER)
  background(255)
  noStroke()
  smooth()

  numOfDaysInMonth =  lengthOfMonth(); 
  # Remember that days are usually counted from 1, not 0.
  d = 1
  while (d <= numOfDaysInMonth):
    dayX = map(d,0,numOfDaysInMonth+1, 0, width); 
    if (d == day()): #draws a circle for the current day
      fill(250, 100, 100);      
      dw = 8;
      dh = 100;
      dl = dayX-dw;
      dr = dayX+dw;
      db = height/2 + dh; 
      dt = height/2 - dh; 
      triangle(dl, dt, dr,dt, dayX, db);
    else:  #draws a bar representing all the other days
      fill(0);
      dw = 5;
      dh = 100;
      dl = dayX-dw;
      dr = dayX+dw;
      db = height/2 + dh/2; 
      dt = height/2 - dh/2; 
      triangle(dl, db, dr, db, dayX, dt);
    d+=1
    
def lengthOfMonth():
    m = month()
    # hardcoded function tells how many days in a given month
    if(m==1 or m==3 or m==5 or m==7 or m==8 or m==10 or m==31):
        return 31
    elif(m ==4 or m==6 or m==9 or m==11):
        return 30
    else:
        if (year()%4 == 0):
            return 29  #leapyear. 
            # note: needs correction for multiples of 100 & 400
        return 28
