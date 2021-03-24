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
  size(700, 500);
  imageMode(CORNER);
  frameRate(60);
  bList = setupBuildings();
  CoinCoinIco = loadImage("CoinCoin_Icon.png");
  showInsuffFnd = false;
  InsuffFndFrame = 0;
  showInsuffBld = false;
  InsuffBldFrame = 0;
}
void draw() {
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

  if (showInsuffFnd) {
    fill(255, 0, 0);
    text("Insufficient funds", width/2, height-20);
  }

  if (showInsuffBld) {
    fill(255, 0, 0);
    text("Insufficient Buildings", width/2, height-40);
  }

  showInsuffBld = InsuffBldFrame > frameCount; 
  showInsuffFnd = InsuffFndFrame > frameCount; 

  //Tick buildings
  if (frameCount % tickRate == 0) {
    for (Building b : bList) {
      coinCoins += b.update(tickRate);
    }
  }
}

ArrayList<Building> setupBuildings() {
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
  CPUMiner.setRate(1);
  CPUMiner.setBaseCost(10);
  CPUMiner.ezGetImage();
  bList.add(CPUMiner);

  //GPU Miner
  Building GPUMiner = new Building((width/2.5) + 150, 100);
  GPUMiner.setType("GPU Miner");
  GPUMiner.setRate(5);
  GPUMiner.setBaseCost(100);
  GPUMiner.ezGetImage();
  bList.add(GPUMiner);

  //MiningMachine
  Building MiningMachine = new Building((width/2.5) + 300, 100);
  MiningMachine.setType("Mining Machine");
  MiningMachine.setRate(30);
  MiningMachine.setBaseCost(500);
  MiningMachine.ezGetImage();
  bList.add(MiningMachine);

  //CloudMiner
  Building CloudMiner = new Building((width/2.5), 300);
  CloudMiner.setType("Cloud Miner");
  CloudMiner.setRate(100);
  CloudMiner.setBaseCost(10000);
  CloudMiner.ezGetImage();
  bList.add(CloudMiner);

  //CryptoJacking Instance
  Building CryptoJacker = new Building((width/2.5)+150, 300);
  CryptoJacker.setType("Cryptojacker Botnet");
  CryptoJacker.setRate(1000);
  CryptoJacker.setBaseCost(100000);
  CryptoJacker.ezGetImage();
  bList.add(CryptoJacker);

  //ElonMuskShitpostBot
  Building TwitterBot = new Building((width/2.5)+300, 300);
  TwitterBot.setType("Twitter Bot");
  TwitterBot.setRate(9999);
  TwitterBot.setBaseCost(10000000);
  TwitterBot.ezGetImage();
  bList.add(TwitterBot);

  return bList;
}

void updateRate() {
  hashRate = 0;
  for (Building b : bList) {
    hashRate += (b.getAmount() * b.getRate());
  }
}

void mousePressed() {
  if (mouseX <= 250 && mouseX >= 50 && mouseY <= 350 && mouseY >= 150) {
    coinCoins++;
  } else {
    for (Building b : bList) {
      //If sell, decrement and give 80% of cost back
      if (b.isSellButtonPressed(mouseX, mouseY)) {
        if (b.getAmount() >= 1) {
          b.decrementAmount();
          coinCoins += b.getCost() * 0.8;
          updateRate();
          b.updateCost();
          InsuffBldFrame = frameCount - 1;
        } else {
          InsuffBldFrame = frameCount + 120;
        }
      }

      //If buy, check balance, then increment and deduct cost
      if (b.isBuyButtonPressed(mouseX, mouseY)) {
        if (coinCoins >= b.getCost()) {
          b.incrementAmount();
          coinCoins -= b.getCost();
          updateRate();
          b.updateCost();
          InsuffFndFrame = frameCount - 1;
        } else {
          InsuffFndFrame = frameCount + 120;
        }
      }
    }
  }
}
