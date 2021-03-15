class SnakeBit {

  int gX;
  int gY;
  SnakeBit s;
  boolean head;

  SnakeBit(int _gX, int _gY, SnakeBit _s) {
    gX = _gX;
    gY = _gY;
    s = _s;
    head = false;
  }

  void setHead(boolean _head) { 
    head = _head;
  }

  void drawBit(Grid _g, boolean _dead) {
    if (!_dead) {
      if (head) {
        _g.setTileColour(gX, gY, color(0, 230, 0));
      } else {
        _g.setTileColour(gX, gY, color(20, 250, 20));
      }
    } else {
      _g.setTileColour(gX, gY, color(250, 20, 20));
    }
  }

  int getX() { 
    return gX;
  }
  int getY() { 
    return gY;
  }

  void setTail(SnakeBit _s) { 
    s = _s;
  }

  boolean isTail() { 
    return s == null;
  }
  boolean isHead() { 
    return head;
  }

  void moveBit(int _x, int _y) {
    if (!isTail()) {
      s.moveBit(gX, gY);
    }

    gX = _x;
    gY = _y;
  }
}
