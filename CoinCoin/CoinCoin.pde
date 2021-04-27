//Control vars
int tickRate = 10; //frames per tick

//User vars
ArrayList<Building> bList;
float coinCoins = 0;
float hashRate = 0;

//UI
PImage CoinCoinIco;
boolean showInsuffFnd;
int InsuffFndFrame;
boolean showInsuffBld;
int InsuffBldFrame;

void setup() {
  //Setup window
  size(700, 500);
  imageMode(CORNER);
  frameRate(60);

  //Create list, load image
  bList = setupBuildings();
  CoinCoinIco = loadImage("CoinCoin_Icon.png");

  //Setup control vars
  showInsuffFnd = false;
  InsuffFndFrame = 0;
  showInsuffBld = false;
  InsuffBldFrame = 0;
}
void draw() {
  //Set background and fill, then draw building info
  background(200);

  fill(0);
  for (Building b : bList) {
    b.drawTheThings();
  }

  //CoinCoin icon and header
  text("CoinCoin Clicker", 50, 30);
  text("It's like cookie clicker but \nwith more crypto", 50, 60);
  image(CoinCoinIco, 50, 150, 200, 200);

  //Stats
  String coinCoin_f = nfc(coinCoins, 2);
  String hashRate_f = nfc(hashRate, 2);
  text("CoinCoin: " + coinCoin_f, 50, height-40);
  text("HashRate: " + hashRate_f, 50, height-20);

  //Decide if to show errors
  showInsuffBld = InsuffBldFrame > frameCount; 
  showInsuffFnd = InsuffFndFrame > frameCount; 

  //Show errors
  if (showInsuffFnd) {
    fill(255, 0, 0);
    text("Insufficient funds", width/2, height-20);
  }

  if (showInsuffBld) {
    fill(255, 0, 0);
    text("Insufficient Buildings", width/2, height-40);
  }

  //Tick buildings
  if (frameCount % tickRate == 0) {
    for (Building b : bList) {
      coinCoins += b.update(tickRate);
    }
  }
}

//Setup Buildings method
ArrayList<Building> setupBuildings() {
  //Create empty list
  ArrayList<Building> bList = new ArrayList<Building>();

  /*
  //Test building
   Building test = new Building((width/2) + 50, 50);
   test.setType("test");
   test.setRate(10);
   test.setCost(0);
   test.ezGetImage();
   bList.add(test);
   */

  //CPU Miner
  Building CPUMiner = new Building((width/2.5), 100);
  CPUMiner.setType("CPU Miner");
  CPUMiner.setRate(0.1);
  CPUMiner.setBaseCost(10);
  CPUMiner.ezGetImage();
  bList.add(CPUMiner);

  //GPU Miner
  Building GPUMiner = new Building((width/2.5) + 150, 100);
  GPUMiner.setType("GPU Miner");
  GPUMiner.setRate(2);
  GPUMiner.setBaseCost(100);
  GPUMiner.ezGetImage();
  bList.add(GPUMiner);

  //MiningMachine
  Building MiningMachine = new Building((width/2.5) + 300, 100);
  MiningMachine.setType("Mining Machine");
  MiningMachine.setRate(200);
  MiningMachine.setBaseCost(1000);
  MiningMachine.ezGetImage();
  bList.add(MiningMachine);

  //CloudMiner
  Building CloudMiner = new Building((width/2.5), 300);
  CloudMiner.setType("Cloud Miner");
  CloudMiner.setRate(2000);
  CloudMiner.setBaseCost(10000);
  CloudMiner.ezGetImage();
  bList.add(CloudMiner);

  //CryptoJacking Instance
  Building CryptoJacker = new Building((width/2.5)+150, 300);
  CryptoJacker.setType("Cryptojacker Botnet");
  CryptoJacker.setRate(2000);
  CryptoJacker.setBaseCost(100000);
  CryptoJacker.ezGetImage();
  bList.add(CryptoJacker);

  //ElonMuskShitpostBot
  Building TwitterBot = new Building((width/2.5)+300, 300);
  TwitterBot.setType("Twitter Bot");
  TwitterBot.setRate(75000);
  TwitterBot.setBaseCost(10000000);
  TwitterBot.ezGetImage();
  bList.add(TwitterBot);

  return bList;
}

//Update the rate, called when a building is bought or sold
void updateRate() {
  hashRate = 0;
  for (Building b : bList) {
    hashRate += (b.getAmount() * b.getRate());
  }
}

//Mouse pressed
void mousePressed() {
  if (mouseX <= 250 && mouseX >= 50 && mouseY <= 350 && mouseY >= 150) {
    //If clicking the coin
    coinCoins += 0.5;
  } else {
    //Test if clicking on buy or sell button for each building
    for (Building b : bList) {
      //If sell, decrement and give 80% of cost back
      if (b.isSellButtonPressed(mouseX, mouseY)) {
        if (b.getAmount() >= 1) {
          //If have buildings to sell, then sell
          b.decrementAmount();
          coinCoins += b.getCost() * 0.8;

          //Update rate and building cost
          updateRate();
          b.updateCost();

          //Update warning
          InsuffBldFrame = frameCount - 1;
        } else {
          //No buildings to sell
          InsuffBldFrame = frameCount + 120;
        }
      }

      //If buy, check balance, then increment and deduct cost
      if (b.isBuyButtonPressed(mouseX, mouseY)) {
        if (coinCoins >= b.getCost()) {
          //If have money to buy, then buy
          b.incrementAmount();
          coinCoins -= b.getCost();

          //Update rate and cost
          updateRate();
          b.updateCost();

          //Update warning
          InsuffFndFrame = frameCount - 1;
        } else {
          //No funds to buy
          InsuffFndFrame = frameCount + 120;
        }
      }
    }
  }
}
