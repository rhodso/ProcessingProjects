class Grid {

  int sizeX;
  int sizeY;
  float tileSize;
  float offsetX;
  float offsetY;

  Tile[][] grid;

  Grid(float _tileSize) {
    tileSize = _tileSize;

    //Calculate max grid size for window size
    sizeX = (int) ((width)/_tileSize);
    sizeY = (int) ((height)/_tileSize);
    grid = new Tile[sizeX][sizeY];

    offsetX = (width-(sizeX*tileSize))/2;
    offsetY = (height-(sizeY*tileSize))/2;

    //Setup each tile with position
    for (int x = 0; x < sizeX; x++) {
      for (int y = 0; y < sizeY; y++) {
        grid[x][y] = new Tile(x, y, (x*_tileSize)+offsetX, (y*_tileSize)+offsetY, _tileSize);
      }
    }

    resetGrid();
  }
  
  Tile[][] getGrid(){
    return grid;
  }

  int getSizeX() { 
    return sizeX;
  }
  int getSizeY() { 
    return sizeY;
  }

  void setTileColour(int _x, int _y, color _c) {
    grid[_x][_y].setColour(_c);
  }

  void resetGrid() {
    for (int x = 0; x < sizeX; x++) {
      for (int y = 0; y < sizeY; y++) {
        grid[x][y].reset();
      }
    }
  }

  void drawGrid() {
    //Tiles
    for (int x = 0; x < sizeX; x++) {
      for (int y = 0; y < sizeY; y++) {
        grid[x][y].drawTile();
      }
    }
  }
}
