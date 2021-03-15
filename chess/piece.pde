class Piece{
  char type;
  boolean white;
  int posX;
  int posY;
  PImage img;
  /*
    If lowercase then white
    If uppercase then black
    
    p = Pawn
    r = Rook (Castle, whatever)
    n = knight
    b = bishop
    k = King
    q = Queen
    
  */
  
  Piece(char _type, boolean _white){
    type = _type;
    white = _white;
    String str = "data/" + this.getRep() + ".png";
    img = loadImage(str);
  }
  Piece(String _rep){
     type = _rep.charAt(0);
     white = Character.isLowerCase(type);
  }
  
  void setPos(int _posX, int _posY){
     posX = _posX;
     posY = _posY;
  }
  
  int getPosX(){ return posX; }
  int getPosY(){ return posY; }
  
  String getRep(){
    String rep = Character.toString(type);
    if(white){
      rep = rep.toLowerCase();
    } else {
      rep = rep.toUpperCase();
    }
    return rep;
  }
  
  void drawPiece(int _squareSize){
      image(img, posX*_squareSize+25, posY*_squareSize+25, _squareSize-5, _squareSize-5);
  } 
  
}
