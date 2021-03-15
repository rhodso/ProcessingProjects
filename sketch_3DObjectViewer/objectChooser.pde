import java.io.*; 
import javax.swing.*; 
import javax.swing.filechooser.*; 

class ObjectChooser {

  ObjectChooser() {}

  String chooseObject() {
    String fp = null;

    log("Starting fc");
    JFileChooser j = new JFileChooser("/home/rhodso/Documents/Programming/Processing/Projects/sketch_3DObjectViewer/data/");
    log("Init fc as data dir");
    j.addChoosableFileFilter(new FileNameExtensionFilter("Only OBJ files", "obj"));
    log("Limited to obj");
    int r = j.showOpenDialog(null); 
    log("Showed open dia");
    
    // if the user selects a file 
    if (r == JFileChooser.APPROVE_OPTION){
      fp = j.getSelectedFile().getAbsolutePath();
    
    }
    
    log("Got path");
    log("Path:");
    log(fp);

    return fp;
  }



  void log(String _msg) {
    System.out.println(_msg);
  }
}
