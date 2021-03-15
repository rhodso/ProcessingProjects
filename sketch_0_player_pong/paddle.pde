class paddle extends gameObject { //<>//

  //AI Vars
  int targetFrame;
  float targetY;
  boolean debug;

  //Score (Not needed)
  int score;

  //Constructor
  paddle(float _x, float _y, float _h, float _w) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    h = _h;
    w = _w;
    drag = 0.1;

    //AI
    targetFrame = -1;
    debug = false;

    //Score
    score = 0;
  }

  //Debug draw toggle
  void invertDebug() { 
    debug = !debug;
  }

  //Overrides

  //Override drawing
  @Override
    void drawObject() {
    fill(255);
    rect(x, y, w, h, 5);
  }

  //Scoring methods
  int getScore() { 
    return score;
  }
  void incrementScore() { 
    score++;
  }

  //Do AI method
  void doAI(ball _b) {

    //Check if we've met the framecount
    if (frameCount > targetFrame) {

      //Some maths I don't understand
      targetY = _b.getY() + (dist(_b.getX(), 0, x, 0)*_b.getYVel())/ abs(_b.getXVel());

      //If the ball isn't on our side, reset to the midpoint
      if (x < width/2) {
        if ( _b.getXVel() > 0) {
          targetY = height/2;
        }
      } else {
        if ( _b.getXVel() < 0) {
          targetY = height/2;
        }
      }

      //Debug draw
      if (debug) {

        //Draw a red circle at X, targetY to show
        //where the target Y is
        fill(255, 0, 0);
        circle(x, targetY, 5);
      }

      //Move the paddle to hit the ball
      if (y < targetY && targetY < y + h) {
        yVel = 0;
      } else if (y < targetY) {
        yVel = 5;
      } else if (y > targetY) {
        yVel = -5;
      } else {
        yVel = 0;
      }
    }
  }
}
