class Ball {
  float x;
  float y;

  float xVel;
  float yVel;

  boolean isHeld;

  Ball(float _x, float _y) {
    x = _x;
    y = _y;

    xVel = -2;
    yVel = 5;

    isHeld = false;
  } 

  void update() {


    //Change the velocity here


    //Collisions in y
    if (y <= 10 || y >= height-10) {
      if (y <= 0) {
        y = 10;
        yVel = abs(yVel)*0.9;
      } else if (y >= height-10) {
        yVel = (abs(yVel)*0.9) * -1;
        y = height-10;
      }
    }

    //Collisions in x
    if (x <= 10 || x >= width-10) {
      if (x <= 0) {
        x = 10;
        xVel = abs(xVel)*0.9;
      } else if (x >= width-10) {
        x = width-10;
        xVel = (abs(xVel)*0.9) * -1;
      }
    }

    if (isHeld) {
      xVel = 0;
      yVel = 0;
      
    } else {

      //Update pos from vel
      x += xVel;
      y += yVel;

      //Gravity
      yVel += 0.68;

      //Drag
      xVel *= 0.99;
      yVel *= 0.99;
    }
  }

  boolean getHeld() { 
    return isHeld;
  }
  void setHeld(boolean _isHeld) { 
    isHeld = _isHeld;
  }
  
  float getX(){ return x; }
  float getY(){ return y; }
  
  void setX(float _x){ x = _x; }
  void setY(float _y){ y = _y; }
  
  void setVel (float _xVel, float _yVel){
    xVel = _xVel;
    yVel = _yVel;
  }

  void drawBall() {
    stroke(0);
    fill(255, 0, 0);
    circle(x, y, 15);
  }
}
