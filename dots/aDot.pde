class aDot {

  //Vars
  private float x;
  private float y;
  private float xVel;
  private float yVel;
  private int targetFrame;

  //Constructor
  aDot() {
    //Random pos
    x = random(1, width-1);
    y = random(1, height-1);

    //Setup randomize
    xVel = 0;
    yVel = 0;
    targetFrame = -1;

    //Randomize
    randomize();
  }

  //Update function
  void update() {

    //Update pos based on velocity
    x += xVel;
    y += yVel;

    //Bounce check
    if (x < -1) {
      xVel *= -1;
    }
    if (x > width+1) {
      xVel *= -1;
    }
    if (y < -1) {
      yVel *= -1;
    }
    if (y > height+1) {
      yVel *= -1;
    }

    //Check if we need to randomize direction
    randomize();
  }

  //Draw a circle
  void drawObj() {
    circle(x, y, 7);
  }

  //Randomize velocity
  void randomize() {
    //If we've reached the target frame
    if (frameCount >= targetFrame) {
      xVel = random(-2, 2);
      yVel = random(-2, 2);

      //Get new target frame
      targetFrame += (int) random(25, 1000);
    }
  }

  //Getters
  float getX() { 
    return x;
  }
  float getY() { 
    return y;
  }
}
