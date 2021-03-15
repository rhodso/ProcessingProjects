class gameObject {

  //Constructors
  gameObject() {
  }
  gameObject(float _x) {
    x = _x;
    y = 0;
    xVel = 0;
    yVel = 0;
    h = 0;
    w = 0;
    drag = 0.1;
  }
  gameObject(float _x, float _y) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    h = 0;
    w = 0;
    drag = 0.1;
  }
  gameObject(float _x, float _y, float _h, float _w) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    h = _h;
    w = _w;
    drag = 0.1;
  }

  //Vars
  protected float x;
  protected float y;
  protected float xVel;
  protected float yVel;
  protected float h;
  protected float w;
  protected float drag;

  //Getters and setters
  public float getX() { 
    return x;
  }
  public float getY() { 
    return y;
  }
  public float getXVel() { 
    return xVel;
  }
  public float getYVel() { 
    return yVel;
  }
  public float getH() { 
    return h;
  }
  public float getW() { 
    return w;
  }
  public float getDrag() { 
    return drag;
  }

  public void setX( float _x ) { 
    x = _x;
  }
  public void setY( float _y ) { 
    y = _y;
  }
  public void setXVel( float _xVel ) { 
    xVel = _xVel;
  }
  public void setYVel( float _yVel ) { 
    yVel = _yVel;
  }
  public void setH( float _h ) { 
    h = _h;
  }
  public void setW( float _w ) { 
    w = _w;
  }
  public void setDrag( float _drag ) { 
    drag = _drag;
  }

  //Methods

  //Some methods added here to ensure it is implimented in the method,
  //but method is empty because drawObject isn't able to have a default 
  void drawObject() {
  }
  void doCollisions(gameObject _g) {
  }

  //Base update methods, can be overridded
  void update() {
    //Add velocity
    x += xVel;
    y += yVel;

    //Add drag
    xVel *= 1-drag;
    yVel *= 1-drag;

    //Check for out of bounds in the y axis
    //No need to check X axis as for that we're either
    //scoring or we're not able to get there
    if (y < 0) {
      y = 0;
      yVel *= -1;
    } else if ((y + h) > height) {
      y = height-h;
      yVel *= -1;
    }
  }
}
