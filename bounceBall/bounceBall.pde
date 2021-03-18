
//Instance of ball
Ball b;

//Control vars
int keyPressDelayFrame = -1; 

//Mouse X/Y and grab radius for ball
float mX = 0;
float mY = 0;
float ballGrabRad = 15;

void setup() {
  //Set size and instantiate ball
  size(500, 500);
   b = new Ball(50, 50);
}

void draw() {
  //Set background, update and then draw ball
  background(200);
  b.update();
  b.drawBall();
  
  //If the ball is being held, then set the X/Y to be the mouse X/Y
  if(b.getHeld()){
     b.setX(mX);
     b.setY(mY);
  }
  
}

void keyPressed() {
  
  //Add short delay between keypresses to mitigate repeats
  if (frameCount > keyPressDelayFrame) {
    keyPressDelayFrame = frameCount + 5;

    //If H is being pressed, then stop the ball
    if (key == 'h') {
      b.setHeld(!b.getHeld());
    }
  }
}

void mouseDragged() {
  
  //If the ball is being clicked on with left click
  if (mouseButton == LEFT) {
    
    //Update mouse X/Y
    mX = mouseX;
    mY = mouseY;
    
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

//When the mouse is released, release the ball
void mouseReleased(){
  b.setHeld(false);
}
