//Flags
boolean getInfo = false;
boolean debug = true;

//Variables we need to store things
String pokemonName = "";
JSONObject jsonData;
PImage pkNormalImage;
PImage pkShinyImage;
httpResponseHelper hrh;
httpResponseHelper hrhGetter;
jsonHelper jh;
String[] types;

int targetFrame = -1;

//Target pokemon because we can't get user input through processing terminal for some reaons
String target = "arceus";

void setup() {
  frameRate(60);
  //Set size, reset pokemon name, and init httpResponseHelper
  size(400, 350);
  textSize(16);
  pokemonName = "";
  hrh = new httpResponseHelper();
  hrhGetter = new httpResponseHelper("http://rhodso.com/sources/store.txt");
}

void draw() {
  if (targetFrame < frameCount) {
    targetFrame = frameCount + 600;

    String checkCache = target;
    target = hrhGetter.doRequest();
    target = target.toLowerCase();
    if (target != checkCache) {
      System.out.println("New target = " + target);
      pokemonName = "";
      pkNormalImage = null;
      getInfo = true;
    }
  }

  //UI
  background(50);
  fill(255);

  //Display info if image loaded
  if (pkNormalImage != null) {
    //Images
    image(pkNormalImage, 20, 20, 180, 180);
    image(pkShinyImage, 220, 20, 180, 180);

    //Image labels
    text("Normal", 80, 200);
    text("Shiny", 300, 200);

    //Data
    text("Name: " + jh.getAttribute("name", 's'), 10, 225);
    text("ID: " + jh.getAttribute("id", 'i'), 10, 260);
    text("Height (m): " + Float.parseFloat(jh.getAttribute("height", 'i'))/10, 10, 295);
    text("Weight (kg): " + Float.parseFloat(jh.getAttribute("weight", 'i'))/10, 10, 330);

    //Types data
    text("Types:", 210, 225);
    text(types[0], 210, 260);
    if (types.length == 2) {
      //If there's a second type, display it
      text(types[1], 210, 295);
    }

    //Else fake we're loading because we probs are
  } else {
    text("Loading...", 20, 150);
  }

  //Get info but only if we need to
  if (getInfo) {
    //Requests
    jsonData = hrh.doRequest(pokemonName);
    if (jsonData == null) {
      //Error occured, don't do anything
    } else {
      //Continue
      jh = new jsonHelper(jsonData);

      //Get images from urls in JSON
      pkNormalImage = loadImage(jh.getObjectAttribute("front_default", 's', "sprites"), "png");
      pkShinyImage = loadImage(jh.getObjectAttribute("front_shiny", 's', "sprites"), "png");

      //Get types
      JSONArray pkTypes = jh.getArray("types");
      types = new String[pkTypes.size()];
      for (int i = 0; i < pkTypes.size(); i++) {

        //Read the types from the over-complicated response from the API
        JSONObject pkType = pkTypes.getJSONObject(i);
        jsonHelper typesHelper = new jsonHelper(pkType);
        JSONObject typeObject = typesHelper.getObject("type");
        jsonHelper typeHelper = new jsonHelper(typeObject);
        types[i] = typeHelper.getAttribute("name", 's');
      }

      //Set flag
      getInfo = false;
    }
  }

  try {
    //Get info only if we need to
    if (pokemonName.equals("")) {     
      pokemonName = target;
      getInfo = true;
    } else {
      getInfo = false;
    }
  } 
  catch(Exception e) {
    //Handle errors but not really
    System.out.println(e.toString());
    getInfo = false;
  }
}

void log(String _msg) {
  //Only log if debug is on
  if (debug) {
    System.out.println(_msg);
  }
}
