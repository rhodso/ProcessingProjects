class Cell{

  //Grid X and Y
  int x;
  int y;
  
  //State (mostly  determines colour
  int state;
  
  //X and Y on screen
  float trueX;
  float trueY;
  
  //Size
  static final float size = 50;
  
  //constructor
  Cell(int _x, int _y, int _state, float _trueX, float _trueY){
    x = _x;
    y = _y;
    state = _state;
    trueX = _trueX;
    trueY = _trueY;
  }
  
  //Get and set state
  int getState(){ return state; }
  void setState(int _state){ state = _state; }
  
  //Draw cell based on state
  void drawCell(){
    switch(state){
        case 1:
          fill(255,0,0); //Red
          break;
        case 2:
          fill(0,0,255); //Blue
          break;
        case 3:
        case 4:
        fill(255,0,255); //Purple
        break;
        default:
          fill(255); //White (blank)
          break;
    }
    circle(trueX, trueY, size);
  }

}
