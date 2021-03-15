MazeGenerator mz;
/*
  *
  *  Code for maze generation stolen from rosetta code:
  *  https://rosettacode.org/wiki/Maze_generation#Processing
  *
  *  Because I'm too stupid to work this out on my own
  *
*/

void setup() {
  ///Set size and framerate
  size(600, 600);
  frameRate(20);
  smooth(4);
  strokeCap(ROUND);
  
  mz = new MazeGenerator();
  mz.setupMaze();
  
}

void draw() {
  background(80, 80, 220);
  mz.drawMaze();
}
