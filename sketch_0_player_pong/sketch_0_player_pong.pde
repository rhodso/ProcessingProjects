paddle p1;
paddle p2;
ball b;

int frameCooldown;

void setup() {
  //Environment
  size(700, 500);
  frameRate(60);

  //Setup
  p1 = new paddle(20.0, height/2.0 - (75/2), 75, 10);
  p2 = new paddle(width-30.0, height/2.0 - (75/2), 75, 10);
  b = new ball(width/2.0, height/2.0, 15); 

  //Serve the ball
  b.serve();
}

void draw() {
  //Draw background
  background(80);

  //Debug Draw
  if (frameCount > frameCooldown) {
    //If key is being pressed
    if (keyPressed) { 
      // If D is pressed (case insensitive)
      if (key == 'd' || key == 'D') { 
        p1.invertDebug();
        p2.invertDebug();

        //Add cooldown so that a key can only be pressed 
        //once every 5 frames. Saves on key repeat
        frameCooldown = frameCount + 5;
      }
    }
  }

  //Updates
  p1.update();
  p2.update();
  b.update();

  //AI
  p1.doAI(b);
  p2.doAI(b);

  //Check for scoring
  b.checkScore(p1, p2);

  //Collisions
  b.doCollisions(p1);
  b.doCollisions(p2);

  //Draw everything
  p1.drawObject();
  p2.drawObject();
  b.drawObject();

  //Draw the score
  text(p1.getScore(), (width/2)-50, 50);
  text(p2.getScore(), (width/2)+50, 50);

  //Draw the current rally
  text(b.getRally(), (width/2), height-60);
  text(b.getHiRally(), (width/2), height-50);
}
