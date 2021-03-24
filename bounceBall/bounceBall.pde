//Ball List
ArrayList<Ball> ballList;

//Control vars
int keyPressDelayFrame = -1; 
boolean doRemove = false;

//Mouse X/Y and grab radius for ball
float mX = 0;
float mY = 0;
float ballGrabRad;

void setup() {
  //Set size and instantiate ball
  size(500, 500);
  ballList = new ArrayList<Ball>(0);
  ballList.add(new Ball(50, 50));
  ballGrabRad = ballList.get(0).getSize();
}

void draw() {
  //Set background, update and then draw ball
  background(200);

  for (Ball b : ballList) {
    //Run the runnable method in a new thread for efficiency
    Thread t = new Thread(b);
    t.start();
  }

  //Draw FPS and ballCount
  fill(0);
  text("FPS: " + (int) frameRate + "\nBallcount: " + ballList.size(), 10, 10);

  //Draw all balls
  for (Ball b : ballList) {
    b.drawBall();
  }

  //For some reason this only removes half the balls, instead of all of them
  if (doRemove) {
    for (int i = 1; i < ballList.size(); i++) {
      ballList.remove(i);
    }
    doRemove = false;
  }
}

void keyPressed() {
  //Add short delay between keypresses to mitigate repeats
  if (frameCount > keyPressDelayFrame) {
    keyPressDelayFrame = frameCount + 5;

    //If B is being pressed, then add new ball
    if (key == 'b') {
      ballList.add(new Ball(50, 50));
    }

    //If R is being pressed, then randomise ball vel
    if (key == 'r') {
      for (Ball b : ballList) {
        b.setVel(random(-5, 5), random(-50, -5));
      }
    }

    //If E is pressed, then pray for your PC and add 500 balls
    if (key == 'e') {
      for (int i = 0; i < 100; i++) {
        ballList.add(new Ball(50, 50));
      }
    }

    //Clear balls back to 1
    if (key == 'y') {
      doRemove = true;
    }
  }
}

void mouseDragged() {
  //If the ball is being clicked on with left click
  if (mouseButton == LEFT) {

    //Update mouse X/Y
    mX = mouseX;
    mY = mouseY;

    for (Ball b : ballList) {
      //If the mouse is within grab range of the ball
      if (b.getX()-ballGrabRad < mouseX) {
        if (b.getX()+ballGrabRad > mouseX) {
          if (b.getY()-ballGrabRad < mouseY) {
            if (b.getY()+ballGrabRad > mouseY) {

              //Set the ball to being held
              b.setHeld(true);

              //Set velocity to mouse velocity, multiply to scale it up a bit
              b.setVel((mouseX - pmouseX)*6, (mouseY - pmouseY)*6);
            }
          }
        }
      }
    }
  }
}

//When the mouse is released, release the ball
void mouseReleased() {
  for (Ball b : ballList) {
    b.setHeld(false);

    //Add slight random offset to velocity of dropped ball
    b.setVel (b.getXVel() + random(0, 1), b.getYVel() + random(0, 1));
  }
}
