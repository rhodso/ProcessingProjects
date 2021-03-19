class Ball implements Runnable{
  
  //Position and velocity
  float x;
  float y;

  float xVel;
  float yVel;

  //Is the ball being held
  boolean isHeld;
  
  //Physical properties
  static final float size = 15;
  color c;

  Ball(float _x, float _y) {
    
    //Set to inital variables
    x = _x;
    y = _y;

    xVel = random(-5,5);
    yVel = random(-5,5);

    isHeld = false;
    
    c = color((int) random(80,255), (int) random(80,255), (int) random(80,255));
  } 

  void update() {
    //Collisions in y
    if (y <= size || y >= height-size) {
      if (y <= 0) {
        y = size;
        yVel = abs(yVel)*0.9;
      } else if (y >= height-size) {
        yVel = (abs(yVel)*0.9) * -1;
        y = height-size;
      }
    }

    //Collisions in x
    if (x <= size || x >= width-size) {
      if (x <= 0) {
        x = size;
        xVel = abs(xVel)*0.9;
      } else if (x >= width-size) {
        x = width-size;
        xVel = (abs(xVel)*0.9) * -1;
      }
    }

    //If the ball is being held, reset velocity
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

  //Draw the ball
  void drawBall() {
    //Ball is a red circle with black outline
    stroke(0);
    fill(c);
    circle(x, y, size);
  }
  
  //Handle ball method
  void handleBall(){
    if(this.getHeld()){
       this.setX(mX);
       this.setY(mY);
    } else { //Else update normally;
      this.update();
    }
    
  }
  
  //Runnable method
  public void run(){
    this.handleBall();
  }

  //Gettters and setters
  boolean getHeld() { return isHeld; }
  void setHeld(boolean _isHeld) { isHeld = _isHeld; }
  
  float getX(){ return x; }
  float getY(){ return y; }
  
  float getXVel(){ return xVel; }
  float getYVel(){ return yVel; }
  
  void setX(float _x){ x = _x; }
  void setY(float _y){ y = _y; }
  
  float getSize(){ return size; }
  
  void setVel (float _xVel, float _yVel){
    xVel = _xVel;
    yVel = _yVel;
  }
}
