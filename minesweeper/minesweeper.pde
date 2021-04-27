Grid g;
int size = 25;

boolean doInput;

void setup(){
  size(702,502);
  frameRate(60);
  
  g = new Grid((int) height/size, (int) width/size, size);
  g.distributeBombs((int) random(50,70));
  doInput = true;
  //g.printGrid();
}

void draw(){
  background(100);
  g.drawGrid();
  for(Tile[] tArr : g.getTiles()){
      for(Tile t : tArr){
         t.badlyFloodFill(g);
      }
   }
}

void mousePressed(){
  if(doInput){
    if (mouseButton == LEFT) {
      g.clickTile(mouseX, mouseY);
      if(g.checkDead()){
        println("Player is kill\nno");
        doInput = false;
        g.revealBombs();
      }
    } else if (mouseButton == RIGHT) {
      g.toggleFlagTile(mouseX, mouseY);
      if(g.checkWin()){
        println("A winner is you");
      }
    } 
  }
}

void keyPressed(){
  if(key == 'c'){
    g.setAllClicked();    
  }
}
