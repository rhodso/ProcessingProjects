PShape s;

float scale = 100;
float objScale = 100;

boolean spin = false;
float spinX = 0.01;
float spinY = 0.01;

int targetFrame = -1;

ObjectChooser oc;

void setup() {
  size(700, 700, P3D);
  oc = new ObjectChooser();
  
  loadNewModel();
}

void draw() {
  background(35);
  spin();
  lights();
  //1st 3 params: XYZ for the camera
  //2nd 3 params: XYZ for scene
  //3rd 3 params: What direction is up (In this case Y)
  camera(0, 0, height/2, 0, 0, 0, 0, 1, 0);
  shape(s);
}

void loadNewModel(){
    //Get model to load
    String fp = oc.chooseObject();
    if(fp != null){
      //If filepath isn't null, load it
      s = loadShape(fp);  
    } 
}

void keyPressed() {
  if (key == 'f' || key == 'F') {
    loadNewModel();
  }
  
  if(key == 's' || key == 'S'){
     spin = !spin;
     println("Spin = " + Boolean.toString(spin));
  }
}

void spin(){
  if(spin){ //Only calculate this stuff if we want to spin
     if(targetFrame <= frameCount){
       switch((int) random(0,3)){
           case 0:
             spinX = 0;
             break;
           case 1:
             spinX = 0.01;
             break;
           case 2:
             spinX = -0.01;
             break;
       }
       if(spinX == 0){ //If X isn't spining, spin Y
         switch((int) random(0,2)){
             case 0:
               spinY = -0.01;
               break;
             case 1:
               spinY = 0.01;
               break;
         }
       } else {
         spinY = 0;
       }
       targetFrame = frameCount + 600; //10 seconds
    }
    
    s.rotateY(spinY);
    s.rotateX(spinX);
  }
}

void mouseDragged(MouseEvent _e) {
  if (mouseButton == CENTER) { //Only do stuff if center button is held
    float xTrans = (mouseX - pmouseX)/scale;
    float yTrans = -1 * ((mouseY - pmouseY)/scale);

    s.rotateY(xTrans);
    s.rotateX(yTrans);
  }
}

void mouseWheel(MouseEvent _e) {
  //When scrolling up we want the scale to increase, so invert count
  if (_e.getCount() == 1) {
    s.scale(1.1);
  } else {
    s.scale(0.9);
  }
}
