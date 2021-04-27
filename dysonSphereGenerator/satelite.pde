class Satelite{
 
  //Vars
  float x;
  float y;
  float xVel;
  float yVel;
  float size;
  
  //Constructor
  Satelite(float _x, float _y, float _xVel, float _yVel){
    x = _x;
    y = _y;
    xVel = _xVel;
    yVel = _yVel;
    
    //Default size, no need to change it really
    size = 5;
  }
  
  void drawSat(){
    //Set colour to white and draw
     fill(255);
     circle(x, y, size);
  }
  
  void updateSat(Star s){
    //Set scale for force scaling
    float scale = 0.001;
    
    //Find accel values
    double xAccel = (s.getX() - x) * scale;
    double yAccel = (s.getY() - y) * scale;
    
    //Update velocity and position
    xVel += xAccel;
    yVel += yAccel;
    x += xVel;
    y += yVel;
  }
  
}
