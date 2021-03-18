Ball b = new Ball(50, 50);

int keyPressDelayFrame = -1; 

float mX = 0;
float mY = 0;

float ballGrabRad = 15;

void setup() {
  size(500, 500);
}

void draw() {
  background(200);
  b.update();
  b.drawBall();
  
  if(b.getHeld()){
     b.setX(mX);
     b.setY(mY);
  }
  
}

void keyPressed() {
  if (frameCount > keyPressDelayFrame) {
    keyPressDelayFrame = frameCount + 5;

    if (key == 'h') {
      b.setHeld(!b.getHeld());
    }
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    mX = mouseX;
    mY = mouseY;
    
    if (b.getX()-ballGrabRad < mouseX) {
      if (b.getX()+ballGrabRad > mouseX) {
        if (b.getY()-ballGrabRad < mouseY) {
          if (b.getY()+ballGrabRad > mouseY) {
            
            b.setHeld(true);
            
            b.setVel((mouseX - pmouseX)*6, (mouseY - pmouseY)*6);
            
          }
        }
      }
    }
  }
}

void mouseReleased(){
  b.setHeld(false);
}
