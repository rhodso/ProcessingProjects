//URL stuff
HttpHelper getter;
HttpHelper setter;
String content;
int targetFrame = -1;

//Game stuff
Game g;
int dir;
int speed = 90;

//Control stuff
boolean doWebStuff = false;

void setup() {
  size(1600, 920);

  //Http helpers
  getter = new HttpHelper("http://rhodso.com/sources/store.txt");
  setter = new HttpHelper("http://rhodso.com/comms.php", new String[] {"data", ""});

  g = new Game(75);

  dir = 1;
}

void keyPressed() {
  //Movement
  if ( key == 'A' || key == 'a') {
    dir--;
  } else if ( key == 'D' || key == 'd') {
    dir++;
  }

  //Check that movement isn't borked
  if (dir < 0) {
    dir = 3;
  } else if (dir > 3) {
    dir = 0;
  }
}

void draw() {
  background(255);
  //Getting the thing from the internet
  if (targetFrame < frameCount) {
    //reset target
    targetFrame = frameCount + 100-speed;

    if (doWebStuff) {
      //Get content
      content = getter.doRequest();
      content = content.toLowerCase();
      if (content != "") {
        //Clear the content on the website to remove multiple readings
        setter.doRequest();
      }

      //Handle content here  
      if (content == "left") {
        dir--;
      } else if (content == "right") {
        dir++;
      }

      //Check that movement isn't borked
      if (dir < 0) {
        dir = 3;
      } else if (dir > 3) {
        dir = 0;
      }
    }
    //Step the world
    g.step(dir);
  }

  g.drawGame();
}
