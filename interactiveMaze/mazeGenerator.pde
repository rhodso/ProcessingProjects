class MazeGenerator {
  int g_size = 10;
  color background_color = color (80, 80, 220);
  color runner = color (255, 50, 50);
  color visited_color = color(220, 240, 240);
  color done_color = color (100, 160, 250);
  color goal_color = color (20, 250, 20);
  int c_size;

  Cell[][] cell;
  ArrayList<Cell> done = new ArrayList<Cell>();
  ArrayList<Cell> visit = new ArrayList<Cell>();
  Cell run_cell;

  void setupMaze() {
    c_size = max(width/g_size, height/g_size);
    cell = new Cell[g_size][g_size];
    for (int i = 0; i < g_size; i++) {
      for (int j = 0; j < g_size; j++) {
        cell[i][j] = new Cell(i, j);
      }
    }
    for (int i = 0; i < g_size; i++) {
      for (int j = 0; j < g_size; j++) {
        cell[i][j].add_neighbor();
      }
    }
    run_cell = cell[0][0];
    visit.add(run_cell);

    while (true) {
      if (visit.size() < g_size*g_size) {
        if (run_cell.check_sides()) {
          Cell chosen = run_cell.pick_neighbor();
          done.add(run_cell);
          run_cell.stacked = true;
          if (chosen.i - run_cell.i == 1) {
            run_cell.wall[1] = false;
            chosen.wall[3] = false;
          } else if (chosen.i - run_cell.i == -1) {
            run_cell.wall[3] = false;
            chosen.wall[1] = false;
          } else if (chosen.j - run_cell.j == 1) {
            run_cell.wall[2] = false;
            chosen.wall[0] = false;
          } else {
            run_cell.wall[0] = false;
            chosen.wall[2] = false;
          }
          run_cell.current = false;
          run_cell = chosen;
          run_cell.current = true;
          run_cell.visited = true;
        } else if (done.size()>0) {
          run_cell.current = false;
          run_cell = done.remove(done.size()-1);
          run_cell.stacked = false;
          run_cell.current = true;
        } else {
          break;
        }
      }
    }
    
    //Setup colours
    cell[][]
  }

  void drawMaze() {
    for (int i = 0; i < g_size; i++) {
      for (int j = 0; j < g_size; j++) {
        cell[i][j].draw_cell();
        cell[i][j].draw_wall();
      }
    }
  }

  class Cell {
    ArrayList<Cell> neighbor;
    boolean visited, stacked, current, goal;
    boolean[] wall;
    int i, j;

    Cell(int _i, int _j) {
      i = _i;
      j = _j;
      wall = new boolean[]{true, true, true, true};
    }

    Cell pick_neighbor() {
      ArrayList<Cell> unvisited = new ArrayList<Cell>();
      for (int i = 0; i < neighbor.size(); i++) {
        Cell nb = neighbor.get(i);
        if (nb.visited == false) unvisited.add(nb);
      }        
      return unvisited.get(floor(random(unvisited.size())));
    }

    void add_neighbor() {
      neighbor = new ArrayList<Cell>();
      if (i>0) {
        neighbor.add(cell[i-1][j]);
      }
      if (i<g_size-1) {
        neighbor.add(cell[i+1][j]);
      }
      if (j>0) {
        neighbor.add(cell[i][j-1]);
      }
      if (j<g_size-1) {
        neighbor.add(cell[i][j+1]);
      }
    }

    boolean check_sides() {
      for (int i = 0; i < neighbor.size(); i++) {
        Cell nb = neighbor.get(i);
        if (!nb.visited) return true;
      } 
      return false;
    }

    void draw_cell() {
      noStroke();
      noFill();
      if (current) fill(runner);
      else if (stacked) fill(done_color);
      else if (visited) fill(visited_color);
      rect(j*c_size, i*c_size, c_size, c_size);
    }

    void draw_wall() {
      stroke(0);
      strokeWeight(5);
      if (wall[0]) line(j*c_size, i*c_size, j*c_size, (i+1)* c_size);
      if (wall[1]) line(j*c_size, (i+1)*c_size, (j+1)*c_size, (i+1)*c_size);
      if (wall[2]) line((j+1)*c_size, (i+1)*c_size, (j+1)*c_size, i*c_size);
      if (wall[3]) line((j+1)*c_size, i*c_size, j*c_size, i*c_size);
    }
  }
}
