class Food{
  int gX;
  int gY;
  boolean eaten;

  Food(){}
  
  boolean isEaten(){ return eaten; }
  
  void spawn(int _x, int _y){
      gX = _x;
      gY = _y;
      eaten = false;
  }
  boolean checkCollision(Snake _snake) {
    //Get the head
    for (SnakeBit head : _snake.getSnake()) {
      if (head.isHead()) {
        if(gX == head.getX()){
          if(gY == head.getY()){
              eaten = true;
             return true; 
          }
        }
        
        //Break after the head to save performance
        break;
      }
    }

    //No collision detected
    return false;
  }
  
  int getX(){ return gX; }
  int getY(){ return gY; }
  
  void drawFood(Grid _g){
    _g.setTileColour(gX, gY, color(255,89,30));
  }
}
