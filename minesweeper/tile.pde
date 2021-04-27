class Tile {
  float x;
  float y;   
  float size;
  int gridX;
  int gridY;
  int bombsAround;
  boolean hasBomb;
  boolean isClicked;
  boolean isFlagged;

  Tile(int _gridX, int _gridY, float _size) {
    gridX = _gridX;
    gridY = _gridY;
    size = _size; 
    x = gridX*_size;
    y = gridY*_size;
    isClicked = false;
  }

  void drawTile() {
    if (!isClicked) { //Tile not clicked
      fill(128);
      stroke(255);
      rect(x, y, size, size);
    } else if (hasBomb && isFlagged) {
      //Draw bomb
      fill(0, 128);
      stroke(0, 128);
      circle(x + size/2, y + size/2, size*0.7);

      //Draw triangle
      fill(100, 128);
      stroke(100, 128);
      rect(x, y, size, size);
      fill(255, 0, 0);
      triangle(x+1, y+1, x+1, (y+size)-1, (x+size)-1, y+1+(size/2));
    } else if (hasBomb) {
      //Draw bomb
      fill(0, 128);
      stroke(0, 128);
      circle(x + size/2, y + size/2, size-4);
    } else if (isFlagged) {
      fill(100);
      stroke(100);
      rect(x, y, size, size);
      fill(255, 0, 0);
      triangle(x+1, y+1, x+1, (y+size)-1, (x+size)-1, y+1+(size/2));
    } else if (bombsAround != 0) { //Tile is clicked, display number
      stroke(100);
      fill(120);
      rect(x, y, size, size);
      switch(bombsAround) {
      case 1:
        fill(255, 0, 0);
        break;
      case 2:
        fill(255, 128, 0);
        break;
      case 3:
        fill(255, 255, 0);
        break;
      case 4:
        fill(0, 255, 0);
        break;
      case 5:
        fill(0, 0, 255);
        break;
      case 6:
        fill(75, 0, 130);
        break;
      case 7:
        fill(148, 0, 211);
        break;
      default:
        fill(0);
        break;
      }
      text(bombsAround, x+7, y+20);
    } else { //Tile is clicked, but no bombs around
      fill(100);
      stroke(100);
      rect(x, y, size, size);
    }
  }

  void calculateBombsAround(Grid _g) {
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        //Skip self
        if (i == 0 && j == 0) { 
          bombsAround = -1;
          continue;
        }

        int targetX = gridX+i;
        int targetY = gridY+j;

        //Using a try-catch here because I can't be bothered to write 
        //Code that avoids the edge of the array.
        //Don't do this
        //Do as I say, not as I do

        try {
          if (_g.getTileHasBomb(targetX, targetY)) {
            continue;
          }
          _g.setTileBombsAround(targetX, targetY);
        } 
        catch(Exception e) {
          continue;
        }
      }
    }
  }

  void badlyFloodFill(Grid _g) {
    if (isClicked && bombsAround == 0) {
      for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
          //Skip self
          if (i == 0 && j == 0) {
            continue;
          }

          int targetX = gridX+i;
          int targetY = gridY+j;
          
          try{
            if(!_g.getTileIsClicked(targetX, targetY) && !g.getTileHasBomb(targetX, targetY)){
              _g.setTileIsClicked(targetX, targetY, true);
            }
          } catch(Exception e){
            
          }
        }
      }
    }
  }

  //Getters and Setters
  boolean getHasBomb() { 
    return hasBomb;
  }
  boolean getIsClicked() { 
    return isClicked;
  }
  boolean getIsFlagged() { 
    return isFlagged;
  }
  int getBombsAround() { 
    return bombsAround;
  }
  int getGridY() { 
    return gridY;
  }
  int getGridX() { 
    return gridX;
  }

  void setHasBomb( boolean _hasBomb) { 
    hasBomb = _hasBomb;
  }
  void setIsClicked( boolean _isClicked ) { 
    isClicked = _isClicked;
  }
  void setIsFlagged( boolean _isFlagged ) { 
    isFlagged = _isFlagged;
  }
  void setBombsAround( int _bombsAround) { 
    bombsAround = _bombsAround;
  }
  void setGridY( int _gridY) { 
    gridY = _gridY;
  }
  void setGridX( int _gridX) { 
    gridX = _gridX;
  }
}
