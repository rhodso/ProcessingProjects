class Star{
 
  //Vars
  float x;
  float y;
  float size;
  
  //Constructor
  Star(){
      x = width/2;
      y = height/2;
      size = 50;
  }
  
  //Getters
  float getX(){ return x; }
  float getY(){ return y; }
  float getSize(){ return size; }
  
  //Setters
  void setX(float _x){ x = _x; }
  void setY(float _y){ y = _y; }
    
  //Draw function
  void drawStar(){
    fill(255,255,0);
    circle(x, y, size);
  }
  
}
