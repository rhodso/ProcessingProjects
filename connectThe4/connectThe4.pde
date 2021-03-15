
Board b;

//Control vars
int winTargetFrame = 6;
int uiTargetFrame = -1;
boolean allowUI = true;

void setup() {
  //Do setup
  size(400, 350);
  frameRate(20);
  b = new Board();
  
  //Draw board initally
  b.drawBoard();
}
void draw() {
  if (!allowUI) {
    //Update cells then draw board
    b.updateCells();
    b.drawBoard();

    //Test for allowing the UI or not
    if (uiTargetFrame == frameCount) {
      allowUI = true;
    }

    //check for winner the frame before UI is allowed again
    if (frameCount +1 == uiTargetFrame) {
      winTargetFrame = frameCount + 6; 
      int win = b.checkWin();
      if (win != 0) {
        //Effectivley stop program and 
        //draw one last time to show win
        noLoop();
        b.drawBoard();
        
        //output based on who won
        if (win == 4) {
          println("Draw");
        } else {
          //println("Winner is " + b.getTurnInv());
          println("Winner is " + win);
        }
      }
    }
  } else {

    //Get UI
    if (keyPressed) {
      
      //Less typing than b.doTurn() for every case
      switch(key) {
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
        b.doTurn(Character.getNumericValue(key) -1);
      }

      //Block user input while we process turn, 
      //then set target frame for max time before 
      //everything processes
      allowUI = false;
      uiTargetFrame = frameCount + 7;
      
      /*
       * You may be wondering why 7 frames?
       * 
       * Well you see there's thing thing in the 
       * real world called gravity, but computers
       * don't know what gravity is, and I have to
       * program that, but I don't want to do that
       *
       * So instead I say "How many rows are there?"
       * well, there's 6. So let's call b.updateCells()
       * 6 times, but we've got to draw it in between 
       * and clear the background
       *
       * The easiest way to do that is to block user
       * input for 6 frames, then draw everything as
       * normal for 6 frames, which includes calling
       * the update for 6 frames, doing gravity and 
       * drawing the thing falling down like you'd
       * expect from the real game in the real world.
       * 
       * However, it's also nice to have 1 additional
       * frame so that we can ensure that everything's
       * settled before we check for a potential win,
       * so the frame before the user can do stuff 
       * again, we check for a win that means we need
       * to wait 7 frames
       * 
       * There may be other ways to do this, but I can't 
       * be bothered to figure them out. Oh well
      */
    }
  }
}
