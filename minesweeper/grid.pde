class Grid{

  int h;
  int w;
  float size;
  int bombCount;
  
  Tile[][] tiles;
  
  Grid(int _h, int _w, float _size){
    h = _h;
    w = _w;
    size = _size;
    
    //Create tiles
    tiles = new Tile[w][h];
    for(int x = 0; x < w; x++){
      for(int y = 0; y < h; y++){
        tiles[x][y] = new Tile(x, y, _size);      
      }  
    }
  }
  
  void distributeBombs(int _bombCount){
    bombCount = _bombCount;
    
    //This is a bad algorithm for doing this 
    //because it could keep picking invalid spots.
    //But there's so few bombs it's ok for now
    //
    //Probably
    for(int i = 0; i < _bombCount; i++){
       int randX = (int) random(0, w);
       int randY = (int) random(0, h);
       
       if(tiles[randX][randY].getHasBomb()){
          i--; 
       } else {
         tiles[randX][randY].setHasBomb(true);
         tiles[randX][randY].calculateBombsAround(this);
       }
    }
    
    //printGrid();
    
  }
  
  boolean getTileHasBomb(int _x, int _y){
    return tiles[_x][_y].getHasBomb();
  }
   
  ///This is a bad way of doing it but I cba to fix
  void clickTile(float _x, float _y){
     tiles[(int)(_x/size)][(int)(_y/size)].setIsClicked(true);
     
     //Now need to trigger the clicked event for all surrounding tiles if bombsAround = 0
     
     
     //Now need to trigger the clicked event for 1st layer of bombsAround != 0
     //Don't need to worry about bombsAround = -1 because there will be a layer of bombsAround != 0
     if(tiles[(int)(_x/size)][(int)(_y/size)].getBombsAround() == 0){
       
       for(int i = -1; i < 2; i++){
        for(int j = -1; j < 2; j++){
          //Skip self
          if(i == 0 && j == 0){ 
            continue;
          }
          
          int targetX = (int) _x/(int) size +i;
          int targetY = (int) _y/(int) size +j;
          
          if(targetX == 0 || targetY == 0){
            continue;
          }
          
          if(targetX > w || targetY > h){
            continue;
          }
          
          tiles[(int)(_x/size)][(int)(_y/size)].badlyFloodFill(this);
        }
      }
     }
  }
  
  void setTileBombsAround(int _x, int _y){ tiles[_x][_y].setBombsAround(tiles[_x][_y].getBombsAround()+1); } //Shortcut to increment
  void setTileBombsAround(int _x, int _y, int _bombsAround){ tiles[_x][_y].setBombsAround(_bombsAround); }
  int getTileBombsAround(int _x, int _y){ return tiles[_x][_y].getBombsAround(); }
  
  int getHeight(){ return h; }
  int getWidth(){ return w; }
  
  void toggleFlagTile(float _x, float _y){
    if(tiles[(int)_x/(int) size][(int)_y/(int) size].getIsFlagged()){
      tiles[(int)_x/(int) size][(int)_y/(int) size].setIsClicked(false);
      tiles[(int)_x/(int) size][(int)_y/(int) size].setIsFlagged(false);  
    } else {
      tiles[(int)_x/(int) size][(int)_y/(int) size].setIsClicked(true);
      tiles[(int)_x/(int) size][(int)_y/(int) size].setIsFlagged(true);
    }
  }
  
  boolean checkWin(){
    int count = 0;
    for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           if(t.getHasBomb() && t.getIsFlagged()){
             count++;
           }
        }
     }
     return count == bombCount;
  }
  
  void revealBombs(){
    for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           if(t.getHasBomb()){
             t.setIsClicked(true);
           }
        }
     }
  }
  
  boolean checkDead(){
    for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           if(t.getHasBomb() && t.getIsClicked() && !t.getIsFlagged()){
             return true;
           }
        }
     }
     return false;
  }
  
  void drawGrid(){
     for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           t.drawTile(); 
        }
     }
  }
  
  void printGrid(){
    for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           if(t.getHasBomb()){ print("1"); } 
           else { print("0"); }
           print(" ");
        }
        println("");
     }
  }
  
  void setAllClicked(){
    for(Tile[] tArr : tiles){
        for(Tile t : tArr){
           t.setIsClicked(true); 
        }
     }
  }
  
  Tile getTile(int _gridX, int _gridY){ return tiles[_gridX][_gridY]; }
  boolean getTileIsClicked(int _gridX, int _gridY){ return tiles[_gridX][_gridY].getIsClicked(); }
  void setTileIsClicked(int _gridX, int _gridY, boolean _isClicked){ tiles[_gridX][_gridY].setIsClicked(_isClicked); }
  Tile[][] getTiles(){ return tiles; }

}
