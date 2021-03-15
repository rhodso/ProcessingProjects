class Snake { //<>//

  ArrayList<SnakeBit> snake;
  boolean dead;
  int dir;
  int cache_dir = -1;

  /*
  *  0 right
   *  1 down
   *  2 left
   *  3 up
   */

  Snake() {
    snake = new ArrayList<SnakeBit>(0);
    SnakeBit b = new SnakeBit(0, 0, null);
    b.setHead(true);
    snake.add(b);
    dir = 0;
  }
  void drawSnake(Grid _g) {
    for (SnakeBit b : snake) {
      b.drawBit(_g, dead);
    }
  }

  ArrayList<SnakeBit> getSnake() { 
    return snake;
  }

  void doAI(Grid _g, Food _f) {
    boolean isCollide = false;

    //Get current X/Y
    int x = 0;
    int y = 0;

    for (SnakeBit sb : snake) {
      if (sb.isHead()) {
        x = sb.getX();
        y = sb.getY();
        break;
      }
    }

    //Test if going to hit self
    //Get the head
    for (SnakeBit head : snake) {
      if (head.isHead()) {

        int testX = x;
        int testY = y;
        switch(dir) {
        case 0: //Right
          testX++;
          break;
        case 1: //Down
          testY++;
          break;
        case 2: //Left
          testX--;
          break;
        case 3: //Up
          testY--;
          break;
        }

        //Infinte horizons
        if (testX < 0) {
          testX = _g.getSizeX()-1;
        } else if (testX == _g.getSizeX()) {
          testX = 0;
        }

        if (testY < 0) {
          testY =_g.getSizeY()-1;
        } else if ( testY == _g.getSizeY()) {
          testY = 0;
        }



        //If the head then check against all other bits in the snake
        for (SnakeBit sb : snake) {
          if (sb.isHead()) {
            //don't collide the head with the head lol
            continue;
          }

          //Check for potential collide
          if (sb.getX() == testX) {
            if (sb.getY() == testY) {
              isCollide = true;
              break;
            }
          }
        }

        if (isCollide) {
          //dont
          if (random(1) == 0) {
            dir++;
          } else {
            dir--;
          }

          //Check that movement isn't borked
          if (dir < 0) {
            dir = 3;
          } else if (dir > 3) {
            dir = 0;
          }
        }

        //Break after the head to save performance
        break;
      }
    }

    //Kinda fixed

    if (!isCollide) {
      if (cache_dir != -1) {
        dir = cache_dir;
        cache_dir = -1;
      } else {
        int curr_dir = dir;
        //Food alignment
        if (_f.getX() == x) {
          if (_f.getY() < y) { //If target is above
            switch(curr_dir) {
            case 0: //Heading right
              dir--;
              break;
            case 1: //Heading down
              if ((int) random(1) == 0) { //Randomly pick left or right
                dir++;
              } else {
                dir--;
              }
              cache_dir = 3;
              break;
            case 2: //Heading left
              dir++;
              break;
            case 3: //Heading up
              //do nothing;
              break;
            }
          } else if (_f.getY() > y) { //If target is below
            switch(curr_dir) {
            case 0: //Heading right
              dir++;
              break;
            case 1: //Heading down
              //Do nothing
              break;
            case 2: //Heading left
              dir--;
              break;
            case 3: //Heading up
              if ((int) random(1) == 0) { //Randomly pick left or right
                dir++;
              } else {
                dir--;
              }
              cache_dir = 1;
              break;
            }
          } else { //On plane of target
          }
        } else if (_f.getY() == y) {
          //Align X
          if (_f.getX() < x) { //If target is left
            switch(curr_dir) {
            case 0: //Heading right
              if ((int) random(1) == 0) { //Randomly pick up or down
                dir++;
              } else {
                dir--;
              }
              cache_dir = 2;
              break;
            case 1: //Heading down
              dir++;
              break;
            case 2: //Heading left
              //Do nothing
              break;
            case 3: //Heading up
              dir--;
              break;
            }
          } else if (_f.getX() > x) { //If target is right
            switch(curr_dir) {
            case 0: //Heading right
              //Do nothing
              break;
            case 1: //Heading down
              dir--;
              break;
            case 2: //Heading left
              if ((int) random(1) == 0) { //Randomly pick up or down
                dir++;
              } else {
                dir--;
              }
              cache_dir = 0;
              break;
            case 3: //Heading up
              dir++;
              break;
            }
          } else { //On plane of target
          }
        } else {
        }


        boolean weGoingToDie = true;
        int infLoopCheck = 0;

        while (weGoingToDie) {
          infLoopCheck++;

          //Check that the chosen dir isn't going to kill us
          int futureX = x;
          int futureY = y;

          switch(dir) {
          case 0:
            futureX++;
            break;
          case 1:
            futureY++;
            break;
          case 2:
            futureX--;
            break;
          case 3:
            futureY--;
            break;
          }

          //Infinte horizons
          if (futureX < 0) {
            futureX = _g.getSizeX()-1;
          } else if (futureX == _g.getSizeX()) {
            futureX = 0;
          }

          if (futureY < 0) {
            futureY =_g.getSizeY()-1;
          } else if ( futureY == _g.getSizeY()) {
            futureY = 0;
          }

          weGoingToDie = checkCollision(futureX, futureY);

          if (weGoingToDie) {
            //Avoid body, to pick a new dir
            dir++; 

            //Check that movement isn't borked
            if (dir < 0) {
              dir = 3;
            } else if (dir > 3) {
              dir = 0;
            }
          } else {
            
          }
          
          if(infLoopCheck > 10){
            //Infinte loop detected. Snake will die wherever we go
            println("Oh no, I'm going to die");
            break;
          }
        }
        
        //Check that movement isn't borked
        if (dir < 0) {
          dir = 3;
        } else if (dir > 3) {
          dir = 0;
        }
      }
    }
  }

  void growSnake() {
    SnakeBit b;
    for (SnakeBit sb : snake) {
      if (sb.isTail()) {
        b = new SnakeBit(sb.getX(), sb.getY(), null);
        sb.setTail(b);
        snake.add(b);
        break;
      }
    }
  }

  void setAlive(boolean _dead) { 
    dead = _dead;
  }

  boolean checkCollision() {

    //Get the head
    for (SnakeBit head : snake) {
      if (head.isHead()) {

        //If the head then check against all other bits in the snake
        for (SnakeBit sb : snake) {
          if (sb.isHead()) {
            //don't collide the head with the head lol
            continue;
          }
          if (head.getX() == sb.getX()) { //Overlap in X
            if (head.getY() == sb.getY()) { //Overlap in y
              return true; //Snek is kill
            }
          }
        }
        //Break after the head to save performance
        break;
      }
    }

    //No collision detected
    return false;
  }

  boolean checkCollision(int _x, int _y) {


    for (SnakeBit sb : snake) {
      if (sb.isHead()) {
        //don't collide the head with the head lol
        continue;
      }
      if (_x == sb.getX()) { //Overlap in X
        if (_y == sb.getY()) { //Overlap in y
          return true; //Snek is kill
        }
      }
    }

    //No collision detected
    return false;
  }

  void moveSnake(Grid _g, int _dir) {   
    if (!dead) {
      //Get current X/Y
      int x = 0;
      int y = 0;

      for (SnakeBit sb : snake) {
        if (sb.isHead()) {
          x = sb.getX();
          y = sb.getY();
          break;
        }
      }

      //Increment
      switch(dir) {
      case 0: //Right
        x++;
        break;
      case 1: //Down
        y++;
        break;
      case 2: //Left
        x--;
        break;
      case 3: //Up
        y--;
        break;
      }

      //Infinte horizons
      if (x < 0) {
        x = _g.getSizeX()-1;
      } else if (x == _g.getSizeX()) {
        x = 0;
      }

      if (y < 0) {
        y =_g.getSizeY()-1;
      } else if ( y == _g.getSizeY()) {
        y = 0;
      }

      //Move the snake
      for (SnakeBit sb : snake) {
        if (sb.isHead()) {
          sb.moveBit(x, y);
          break;
        }
      }
    }
  }
}
