import java.util.Arrays;
import java.util.Random;

class Game {

  Grid g;
  Snake s;
  Food f;

  Game(float _tileSize) {
    g = new Grid(_tileSize);
    s = new Snake();
    f = new Food();
    spawnNewFood();
  }
  void drawGame() {
    //Reset, "draw" the snake and food, then draw the grid
    g.resetGrid();
    s.drawSnake(g);
    f.drawFood(g);
    g.drawGrid();
  }
  void step(int _dir) {
    //Move snake, and check for collisions with itself and food
    s.doAI(g, f);
    s.moveSnake(g, _dir);
    s.setAlive(s.checkCollision());
    f.checkCollision(s);
    
    //If the food's been eaten, spawn new and grow the snake
    if (f.isEaten()) {
      spawnNewFood();
      s.growSnake();
    }
  }

  void growSnake() { 
    s.growSnake();
  }

  void spawnNewFood() {
    ArrayList<Tile> tileList = new ArrayList<Tile>();
    for (Tile[] array : g.getGrid()) {
      tileList.addAll(Arrays.asList(array));
    }

    //for each snakebit
    for (SnakeBit sb : s.getSnake()) {
      
      //for each tile
      for (Tile t : tileList) {
        
        //If the snakebit is on that tile, remove the tile as a valid spawning space
        if (sb.getX() == t.getGridX()) {
          if (sb.getY() == t.getGridY()) {
            tileList.remove(t);
          }
        }
        
        //break when done
        break;
      }
    }
    
    //Now pick a random tile from tileList to spawn the food
    Random r = new Random();
    Tile spawntile = tileList.get(r.nextInt(tileList.size()));
    
    f.spawn(spawntile.getGridX(), spawntile.getGridY());
    
  }
}
