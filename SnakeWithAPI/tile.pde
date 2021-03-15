class Tile{

  float posX;
  float posY;
  int gridX;
  int gridY;
  float tSize;
  color c;
  
  Tile(int _gridX, int _gridY, float _posX, float _posY, float _tSize){
    gridX = _gridX;
    gridY = _gridY;
    posX = _posX;
    posY = _posY;
    tSize = _tSize;
    c = (80);
  }
  Tile(int _gridX, int _gridY, float _posX, float _posY, float _tSize, color _c){
    gridX = _gridX;
    gridY = _gridY;
    posX = _posX;
    posY = _posY;
    tSize = _tSize;
    c = _c;
  }
  
  void setColour(color _c){
    c = _c;
  }
  
  int getGridX(){ return gridX; }
  int getGridY(){ return gridY; }
  
  void drawTile(){
    fill(c);
    rect(posX, posY, tSize, tSize);
  }
  void reset(){
    c = (80);
  }
  
}
