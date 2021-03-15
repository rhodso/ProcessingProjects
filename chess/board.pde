class Board {

  String[][] board;
  int squareSize;
  ArrayList<Piece> pieces;

  Board(int _squareSize) {
    squareSize = _squareSize;
    pieces = initBoard();
    board = new String[8][8];
  }

  ArrayList<Piece> initBoard() {
    ArrayList<Piece> pieces = new ArrayList<Piece>();

    //Pawns
    for (int i = 0; i < 2; i++) {
      boolean col = i == 0; 
      for (int j = 0; j < 8; j++) {
        Piece p = new Piece('p', col);
        p.setPos(j, 1+(i*5));
        pieces.add(p);
      }
    }

    //Rooks or castles whatever you want to call them
    for (int i = 0; i < 2; i++) {
      boolean col = i == 0; 
      Piece p = new Piece('r', col);
      p.setPos(0, i*7);
      pieces.add(p);
      p = new Piece('r', col);
      p.setPos(7, i*7);
      pieces.add(p);
    }
    
    //kNights
    for (int i = 0; i < 2; i++) {
      boolean col = i == 0; 
      Piece p = new Piece('n', col);
      p.setPos(1, i*7);
      pieces.add(p);
      p = new Piece('n', col);
      p.setPos(6, i*7);
      pieces.add(p);
    }
    
    //Bishops
    for (int i = 0; i < 2; i++) {
      boolean col = i == 0; 
      Piece p = new Piece('b', col);
      p.setPos(2, i*7);
      pieces.add(p);
      p = new Piece('b', col);
      p.setPos(5, i*7);
      pieces.add(p);
    }
    
    //White queen
    Piece p = new Piece('q', true);
    p.setPos(4,0);
    pieces.add(p);
    
    //Black queen
    p = new Piece('q', false);
    p.setPos(3,7);
    pieces.add(p);
    
    //White king
    p = new Piece('k', true);
    p.setPos(3,0);
    pieces.add(p);
    
    //Black king
    p = new Piece('k', false);
    p.setPos(4,7);
    pieces.add(p);
    
    return pieces;
  }

  void drawBoard() {
    boolean fillWhite = true;
    stroke(128);
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {

        if (fillWhite) {
          fill(255);
        } else {
          fill(0);
        }
        rect(squareSize*i+20, squareSize*j+20, squareSize, squareSize);
        fillWhite = !fillWhite;
      }
      fillWhite = !fillWhite;
    }
  }

  void drawPieces() {
    for (Piece p : pieces) {
      p.drawPiece(squareSize);
    }
  }
}
