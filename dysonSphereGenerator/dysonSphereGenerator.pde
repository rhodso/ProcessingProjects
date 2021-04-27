//Vars
Star s;
ArrayList<Satelite> sats;
boolean limit = false;

void setup(){
  //Set size and such
  size(1000,1000);
  frameRate(60);
  
  //Init vars
  s = new Star();
  sats = new ArrayList<Satelite>();
}

void draw(){
  //Draw background and star
  background(20);
  s.drawStar();
  
  //No threads unless performance is kill
  for(Satelite sat : sats){
    sat.updateSat(s);
    sat.drawSat();
  }
  
  //Draw overlay
  fill(255);
  text("FPS: " + (int) frameRate + "\nCount: " + sats.size(), 10, 10);
}

void mouseDragged(){
  //If mouse is over star, then drag star
  if(dist(mouseX, mouseY, s.getX(), s.getY()) <= s.getSize()){
    s.setX(mouseX);
    s.setY(mouseY);
  } else {
    //Limit to only spawning 1 per mouse drag
    if(!limit){
      //Spawn a new satelite
      sats.add(new Satelite(mouseX, mouseY,(mouseX - pmouseX)*3, (mouseY - pmouseY)*3));
      limit = true;
    }  
  }
}

//Reset the limit on release
void mouseReleased(){ limit = false; }

void keyPressed() {
  //If C is being pressed, then clear
  if (key == 'c') {
    sats.clear();
  }
}
