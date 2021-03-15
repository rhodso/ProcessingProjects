class ball extends gameObject {

  //Rally vars
  int rally;
  int hiRally;
  boolean isLeft;

  //Constructor
  ball(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    h = _r;
    w = _r;
    drag = 0.0;
  }

  //Check for a score
  void checkScore(paddle p1, paddle p2) {

    //If the ball is off screen
    if (x < 0 || x > width) {
      //Increment score of opposite player
      if (x < width/2) {
        p2.incrementScore();
      } else {
        p1.incrementScore();
      }

      //Serve the ball
      serve();
    }
  }

  //Serve the ball
  void serve() {
    //Set the ball to be the middle
    x = width/2.0;
    y = height/2.0;   

    //Check for high rally
    if (rally > hiRally) {
      hiRally = rally;
    }

    //Reset rally
    rally = 0;

    //Do some maths
    float randAngle = random(0, 100) - 50.0; // Any angle +/- 50 deg
    xVel = 5 * cos(radians(randAngle));
    yVel = 5 * sin(radians(randAngle));

    //Randomly inverse direction to serve left
    if (random(0, 1) < 0.5) {
      xVel *= -1;
      yVel *= -1;
    }
  }

  int getRally() { 
    return rally;
  }
  int getHiRally() { 
    return hiRally;
  }

  //Override drawing method
  @Override
    void drawObject() {
    fill(255);
    circle(x, y, h);
  }

  //Override collisions method
  @Override
    void doCollisions(gameObject _g) {

    //If overlapping the target bat
    if ((_g.getY() - this.h)< this.y) {
      if ((_g.getY() + _g.getH() + this.h) > this.y) {
        if ((_g.getX() - this.w) < this.x) {
          if ((_g.getX() + _g.getW() + this.w) > this.x) {

            //Inverse X velocity
            xVel *= -1;

            //Get a angle proportional to where the ball was hit
            float angle = radians(((_g.getY() + _g.getH()) - y)/10);

            //Add to Y velocity
            if (yVel <= 0) {
              yVel -= sin(angle);
            } else {
              yVel += sin(angle);
            }

            //Ensure that the ball isn't stuck going up and down 
            if (xVel <= 0) {
              xVel -= (abs(_g.getYVel())*0.2);
            } else {
              xVel += (abs(_g.getYVel())*0.2);
            }
            if (yVel <= 0) {
              yVel -= (abs(_g.getYVel())*0.2);
            } else {
              yVel += (abs(_g.getYVel())*0.2);
            }

            //Increment rally
            rally++;
          }
        }
      }
    }
  }
}
