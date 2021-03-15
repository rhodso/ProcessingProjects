class Board {

  //Define board
  Cell[][] cells;
  int cols = 7;
  int rows = 6; 

  //Turn indicator
  int turn;

  Board() {
    //Create cells on board
    cells = new Cell[cols][rows];
    //For every cell in board, initalise
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 6; j++) {
        cells[i][j] = new Cell(i, j, 0, 50*(i+1), 50*(j+1));
      }
    }

    //p1 goes first
    turn = 1;
  }

  //Getters for the turn
  int getTurn() { 
    return turn;
  }
  int getTurnInv() { 
    if (turn == 1) { 
      return 2;
    } else {
      return 1;
    }
  }

  //Do the turn, keeps track of who's turn it is
  void doTurn(int _pos) {
    cells[_pos][0].setState(turn);
    if (turn == 1) { 
      turn = 2;
    } else {
      turn = 1;
    }
  }

  void drawBoard() {
    background(10);
    //For every cell in board, draw
    for (Cell[] col : cells) {
      for (Cell c : col) {
        c.drawCell();
      }
    }

    //Draw headers
    if(turn == 1){
       fill(255,0,0); 
    } else {
      fill(0,0,255);
    }
    for (int i = 0; i < 7; i++) {
      text(i+1, (i*50)+46, 15);
    }
  }

  void updateCells() {
    for (int i = 0; i < cols; i++) {
      for (int j = rows-1; j  > 0; j--) { //Go from bottom to top, but ignore top line (As there's nothing to update)
        /*
         * If I'm not empty (state != 0) do nothing
         * If I am empty then check above for possible gravity update
         */

        if (cells[i][j].getState() == 0) {
          if (cells[i][j-1].getState() != 0) {
            //Copy state from above, then set cell above to blank state
            cells[i][j].setState(cells[i][j-1].getState());
            cells[i][j-1].setState(0);
          }
        }
      }
    }
  }


  int checkWin() {    
    //Check for draw first
    boolean isDraw = true;
    
    //See if there's at least 1 blank cell, if there is then no draw
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j  < rows; j++) {
        if (cells[i][j].getState() == 0) {
          isDraw = false;
          break;
        }
      }
      if (!isDraw) {
        break;
      }
    }

    //If it is draw, everything is purple
    if (isDraw) {
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j  < rows; j++) {
          cells[i][j].setState(4);
        }
      }

      return 4;
    } else {
      //It's not a draw    
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j  < rows; j++) {
          if (cells[i][j].getState() == 0) {
            //If state is blank then skip
            continue;
          }

          //Up
          if (j > 2) { //if the 4 states match, then return true
            if (cells[i][j].getState() == cells[i][j-1].getState()) {
              if (cells[i][j].getState() == cells[i][j-2].getState()) {
                if (cells[i][j].getState() == cells[i][j-3].getState()) {
                  //Win diag and purple things
                  println("Win detected at " + i + "," + j + " going up");
                  cells[i][j].setState(3);
                  cells[i][j-1].setState(3);
                  cells[i][j-2].setState(3);
                  cells[i][j-3].setState(3);
                  return getTurnInv();
                }
              }
            }
          }

          //Right
          if (i < 4) {
            if (cells[i][j].getState() == cells[i+1][j].getState()) {
              if (cells[i][j].getState() == cells[i+2][j].getState()) {
                if (cells[i][j].getState() == cells[i+3][j].getState()) {
                  //Win diag and purple things
                  println("Win detected at " + i + "," + j + " going right");
                  cells[i][j].setState(3);
                  cells[i+1][j].setState(3);
                  cells[i+2][j].setState(3);
                  cells[i+3][j].setState(3);
                  return getTurnInv();
                }
              }
            }
          }

          //Up + Right
          if (i < 4 && j > 2) {
            if (cells[i][j].getState() == cells[i+1][j-1].getState()) {
              if (cells[i][j].getState() == cells[i+2][j-2].getState()) {
                if (cells[i][j].getState() == cells[i+3][j-3].getState()) {
                  //Win diag and purple things
                  println("Win detected at " + i + "," + j + " going up and right");
                  cells[i][j].setState(3);
                  cells[i+1][j-1].setState(3);
                  cells[i+2][j-2].setState(3);
                  cells[i+3][j-3].setState(3);
                  return getTurnInv();
                }
              }
            }
          }

          //Down + Right
          if ( i < 4 && j < 3) {
            if (cells[i][j].getState() == cells[i+1][j+1].getState()) {
              if (cells[i][j].getState() == cells[i+2][j+2].getState()) {
                if (cells[i][j].getState() == cells[i+3][j+3].getState()) {
                  //Win diag and purple things
                  println("Win detected at " + i + "," + j + " going down and right");
                  cells[i][j].setState(3);
                  cells[i+1][j+1].setState(3);
                  cells[i+2][j+2].setState(3);
                  cells[i+3][j+3].setState(3);
                  return getTurnInv();
                }
              }
            }
          }
          
          //End of the dir loops. I wouldn't normally put this in here
          //But I felt it nessesary since this is lots of }'s in a row
        }
      }
    }
    return 0;
  }
}
