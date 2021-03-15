class aDot {

  //Vars
  private float x;
  private float y;
  private float xVel;
  private float yVel;
  private int targetFrame;
  private PImage dotImage;
  httpResponseHelper hrh;
  jsonHelper jh;

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

    dotImage = getPokemonImage();
  }

  PImage getPokemonImage() {
    hrh = new httpResponseHelper();

    //I'm aware this is bad
    //shhhhh
    JSONObject jsonData;
    int id = (int) random(1, 128);
    jsonData = hrh.doRequest(String.valueOf(id));

    if (jsonData == null) {
      //Panic
      return null;
    } else {
      jh = new jsonHelper(jsonData);

      return loadImage(jh.getObjectAttribute("front_default", 's', "sprites"), "png");
    }
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
    if (dotImage == null) {
      circle(x, y, 7);
    } else {
      image(dotImage, x-25, y-25, 50, 50); 
    }
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
