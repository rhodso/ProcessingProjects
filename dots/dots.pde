//Size of array of dots
int size = 200;
aDot[] dots = new aDot[size];

void setup() {
  //Env
  size(1000, 700);
  frameRate(60);

  //Init all dots
  for (int i = 0; i < size; i++) {
    dots[i] = new aDot();
  }
}
void draw() {
  //Background
  background(20);

  //Update and draw all dots
  fill(255);
  stroke(255);
  for (aDot d : dots) {
    d.update();
    d.drawObj();
  }

  //For each dot
  for (aDot d : dots) {
   
    /*
     * I'd usually multithread this,
     * but that's hard to do, with 
     * processing at this level
    */
    
    //For each dot
    for (aDot t : dots) {
      
      //If distance to dot is under 50
      float dotDist =  dist(d.getX(), d.getY(), t.getX(), t.getY());
      if (dotDist < 50) {
        
        //Create a stroke that's less grey the closer the dots are, and draw a line
        stroke(255/50 * dotDist);
        line(d.getX(), d.getY(), t.getX(), t.getY());
      }
    }
  }
  
  //Draw dot on top so we don't get the lines on top of the dots
  for (aDot d : dots) {
    d.drawObj();
  }
}
