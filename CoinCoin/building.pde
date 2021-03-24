class Building {

  //Building vars
  float rate; //Rate of notCookies per second
  float baseCost;
  float cost;
  int amount;
  String type;
  PImage image;

  //Button vars
  float x;
  float y;

  Building(float _x, float _y) {
    //Defaults
    rate = 0;
    cost = 0;
    baseCost = 0;
    amount = 0;
    type = "";
    image = null;

    //Button vars;
    x = _x;
    y = _y;
  }

  //Update function, called once per tick
  float update(float _tickRate) {
    return (rate/_tickRate) * amount;
  }

  //Draw stuff
  void drawTheThings() {
    //Draw the related image
    image(image, x, y, 100, 100);
    
    //Draw the number of buildings, and name + cost
    text(amount,x+45, y+115);
    String cost_f = nfc(cost, 2);
    text(type + "\nCost: \n" + cost_f, x, y-30);
    
    //Draw the buy/sell buttons
    fill(120);
    stroke(20);

    //Buttons
    rect(x, y+100, 35, 25);    
    rect(x+65, y+100, 35, 25);
    
    //Text
    stroke(0);
    fill(0);
    text("Sell", x+3, y+115);
    text("Buy", x+73, y+115);
  }

  void updateCost(){
    //Change cost by 1% each time one is bought/sold
    cost = baseCost * (1+(amount / 1000.0));
  }
  
  //Test for buy or sell being pressed
  boolean isSellButtonPressed(float _mouseX, float _mouseY) {
    if (_mouseX > x && _mouseX < x+35) {
      if (_mouseY > y+100&& _mouseY < y+125) {
        return true;
      }
    }
    return false;
  }
  boolean isBuyButtonPressed(float _mouseX, float _mouseY) {
    if (_mouseX > x+65 && _mouseX < x+100) {
      if (_mouseY > y+100 && _mouseY < y+125) {
        return true;
      }
    }
    return false;
  }

  void ezGetImage() {
    //Shortcut for setting the image based on the type
    image = loadImage("data/" + type + ".png");
  }
  
  //Shortcut for buy/sell
  void incrementAmount(){ amount++; }
  void decrementAmount(){ amount--; }

  //Getters and setters
  float getRate() { 
    return rate;
  }
  float getCost() { 
    return cost;
  }
  int getAmount() { 
    return amount;
  }
  PImage getImage() { 
    return image;
  }
  String getType() { 
    return type;
  }

  void setRate( float _rate) { 
    rate = _rate;
  }
  void setCost( float _cost) { 
    cost = _cost;
  }
  void setBaseCost( float _baseCost) { 
    //Set cost and base cost, since this is only called once at setup
    baseCost = cost = _baseCost;
  }
  void setAmount( int _amount) { 
    amount = _amount;
  }
  void setImage( PImage _image) { 
    image = _image;
  }
  void setType( String _type) { 
    type = _type;
  }
}
