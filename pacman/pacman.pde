float size = 50;
float x = width/2;
float y = height/2;
int states = 100;
int angle = 0;
int speed = 2;

void setup(){
  //4k 120fps (as requested)
  //frameRate(120);
  //size(3840,2160);
  size(500,500);
}

void draw(){
  background(20);
  
  //Setup translation
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  
  //Move
  switch(angle){
    case 0: //Direction is right
       x += speed;
       if(x >= width){
         x = 1;
       }
     break;
     case 90: //Direction is down
       y += speed;
       if(y >= height){
         y = 1;
       }
     break;
     case 180: //Direction is left
       x -= speed;
       if(x <= 0){
         x = width-1;
       }
     break;
     case 270: //Direction is up
       y -= speed;
       if(y <= 0){
         y = height -1;
       }
     break;
     default:
     break;
  }
  
  //Draw 3x3 grid of pacmen
  fill(color(255,255,0));
  for(int drawX = -width; drawX < width*2; drawX += width){
    for(int drawY = -height; drawY < height*2; drawY += height){
      drawPacman(drawX, drawY, size, states);    
    }
  }
  
  //Pop the matrix
  popMatrix();
}

//User input
void keyPressed(){
   if(key == 'a' || key == 'A'){
     angle = 180;
   } else if(key == 'd' || key == 'D'){
     angle = 0;
   } else if(key == 'w' || key == 'W'){
     angle = 270;
   } else if(key == 's' || key == 'S'){
     angle = 90;
   }
}

/*
 * Function to draw pacman at given X/Y, and a given size 
*/
void drawPacman(float _x, float _y, float _size, int _states){
  arc(_x, _y, _size, _size, radians(abs(sin((frameCount % _states)/(2*PI))*50)), radians(360-(abs(sin((frameCount % _states)/(2*PI))*50))), PIE);
}

void drawPacamnExp(float _x, float _y, float _size, int _states){
    //Get state by frameCount mod states
    int state = frameCount % _states;
    
    //Get start and end angle using fancy maths formula that I 
    //only really kinda understand how it works, then endAngle
    //is just 360 minus that since it's essentially reflected 
    //in a line drawn at 0 degrees
    float startAngle = abs(sin((state)/(2*PI))*50);
    float endAngle = 360 - startAngle;
    
    //Convert it to radians because processing likes radians for 
    //drawing things but radians are hard and I don't like hard 
    //things because I'm a programmer and programmers are lazy
    startAngle = radians(startAngle);
    endAngle = radians(endAngle);
    
    //Put it all together
    //X, Y, and size are passed as parameters because we might 
    //want to change them later.Size is specified twice because 
    //that's X size and Y size, but since it's a circle we can 
    //just use the same size. We draw in PIE mode because then
    //it looks right (like a pie chart)
    arc(_x, _y, _size, _size, startAngle, endAngle, PIE);
}
