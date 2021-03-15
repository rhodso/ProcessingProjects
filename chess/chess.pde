Board b;
int squareSize = 100;

HttpHelper getter;
HttpHelper setter;
String content;
int targetFrame = -1;

void setup() {
  size(840, 840);
  b = new Board(squareSize);

  //Http helpers
  getter = new HttpHelper("http://rhodso.com/sources/store.txt");
  setter = new HttpHelper("http://rhodso.com/comms.php", new String[] {"data",""});
}

void draw() {
  background(0);
  b.drawBoard();
  b.drawPieces();

  if (targetFrame < frameCount) {
    //reset target
    targetFrame = frameCount + 600;

    //Get content
    content = getter.doRequest();

    if (content != "") {
      //Clear the content on the website to remove multiple readings
        setter.doRequest();
    }
  }
  
  //Handle content here
  
  
}
