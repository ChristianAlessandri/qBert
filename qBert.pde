//LIBRARIES
import processing.sound.*;


//VARIABLES
//Font
PFont font;


//Sounds
SoundFile soundInsertCoin;
SoundFile soundBonus;
SoundFile soundJump;
SoundFile soundJumpSnake;
SoundFile soundJumpBall;
SoundFile soundJumpSlick;
SoundFile soundCaught;
SoundFile soundFall;
SoundFile soundSnakeFall;
SoundFile soundWin;
SoundFile soundMenu;
SoundFile soundGameOver;
SoundFile soundUgg;
boolean menu;


//Scenes
int winCond;
int timeToLose;
int timeToWin;
int timeToCollision;
boolean start;
boolean startScene;
boolean menuScene;
boolean gameScene;
boolean winScene;
boolean loseScene;
boolean collisionScene;
boolean choiceScene;


//UI
PImage cabinCruiser;
PImage title;
int iCabinCruiser;
float cabinCruiserY;
float cabinCruiserW;
float cabinCruiserH;


//HUD
PImage[] playerNumberTitle = new PImage[2];
int choicePlayer = 0;
PImage[] playerTitle = new PImage[6];
PImage changeToTitle;
PImage[] changeToCube = new PImage[4];
PImage lifeTitle;
int timeToPlayer;


//Score & Levels
int lvl;
int score, bestScore;


//Cubes
PImage[] imgCube = new PImage[8];
Cube[] cube = new Cube[28];
float[][] cubePos = new float[28][2];


//Bonus
PImage[] imgBonus = new PImage[16];
Bonus[] bonus = new Bonus[2];
float[][] bonusPos = new float[2][2];

int timeToStop;
boolean stopTime;


//qBert
PImage imgCaught;
PImage[][] imgQBert = new  PImage[4][2];
QBert qBert = new QBert();


//Enemies
//Snake
PImage[] imgSnakeBall = new  PImage[2];
PImage[][] imgSnake = new  PImage[4][2];
Snake snake = new Snake();
int timeToSpawnSnake;
boolean snakeAlive;

//Ugg
PImage[][] imgUgg = new  PImage[2][2];
Ugg ugg = new Ugg();
int timeToSpawnUgg;
boolean uggAlive;

//Balls
Ball[] ball = new Ball[3];
boolean[] ballAlive = new boolean[3];
int ballCount, timeToSpawnBall;

//Green Balls
GreenBall greenBall;
boolean greenBallAlive;
int timeToSpawnGreenBall;
int rR, rG, rB;

//Sam
Sam sam = new Sam();
int timeToSpawnSam;
boolean samAlive;

//Slick
Slick slick = new Slick();
int timeToSpawnSlick;
boolean slickAlive;




//SETUP
void setup(){
  //Set Display
  size(512, 480);
  frameRate(16);
  
  
  //Set Mode
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  
  
  //Font
  font = createFont("assets/font/slkscr.ttf", 64);
  textFont(font);
  
  
  //Images
  //UI
  cabinCruiser = loadImage("assets/images/ui/cabinCruiser.png");
  title = loadImage("assets/images/ui/title.png");
  
  
  //HUD
  for(int i=0; i<6; i++)
    playerTitle[i] = loadImage("assets/images/hud/player" + i + ".png");
  playerNumberTitle[0] = loadImage("assets/images/hud/player_number1.png");
  playerNumberTitle[1] = loadImage("assets/images/hud/player_number2.png");
  changeToTitle = loadImage("assets/images/hud/change_to.png");
  changeToCube[0] = loadImage("assets/images/cubes/1.png");
  changeToCube[0].resize(32, 32);
  changeToCube[1] = loadImage("assets/images/cubes/3.png");
  changeToCube[1].resize(32, 32);
  changeToCube[2] = loadImage("assets/images/cubes/5.png");
  changeToCube[2].resize(32, 32);
  changeToCube[3] = loadImage("assets/images/cubes/7.png");
  changeToCube[3].resize(32, 32);
  lifeTitle = loadImage("assets/images/hud/life.png");


  //Cube
  for(int i=0; i<8; i++)
    imgCube[i] = loadImage("assets/images/cubes/" + i + ".png");
  
  for(int i=0; i<16; i++)
    imgBonus[i] = loadImage("assets/images/bonus/" + i + ".png");
  
  
  //qBert
  imgCaught = loadImage("assets/images/qBert/caught.png");
  imgQBert[0][0] = loadImage("assets/images/qBert/idle_updx.png");    //Up Key    (W)
  imgQBert[0][1] = loadImage("assets/images/qBert/jump_updx.png");    //Up Key    (W)
  imgQBert[1][0] = loadImage("assets/images/qBert/idle_downdx.png");  //Right Key (D)
  imgQBert[1][1] = loadImage("assets/images/qBert/jump_downdx.png");  //Right Key (D)
  imgQBert[2][0] = loadImage("assets/images/qBert/idle_downsx.png");  //Down Key  (S)
  imgQBert[2][1] = loadImage("assets/images/qBert/jump_downsx.png");  //Down Key  (S)
  imgQBert[3][0] = loadImage("assets/images/qBert/idle_upsx.png");    //Left Key  (A)
  imgQBert[3][1] = loadImage("assets/images/qBert/jump_upsx.png");    //Left Key  (A)
  
  
  //Enemies
  //Snake
  imgSnakeBall[0] = loadImage("assets/images/enemies/snake/idle_ball.png");
  imgSnakeBall[1] = loadImage("assets/images/enemies/snake/jump_ball.png");
  imgSnake[0][0] = loadImage("assets/images/enemies/snake/idle_updx.png");
  imgSnake[0][1] = loadImage("assets/images/enemies/snake/jump_updx.png");
  imgSnake[1][0] = loadImage("assets/images/enemies/snake/idle_downdx.png");
  imgSnake[1][1] = loadImage("assets/images/enemies/snake/jump_downdx.png");
  imgSnake[2][0] = loadImage("assets/images/enemies/snake/idle_downsx.png");
  imgSnake[2][1] = loadImage("assets/images/enemies/snake/jump_downsx.png");
  imgSnake[3][0] = loadImage("assets/images/enemies/snake/idle_upsx.png");
  imgSnake[3][1] = loadImage("assets/images/enemies/snake/jump_upsx.png");
  
  //Ugg
  imgUgg[0][0] = loadImage("assets/images/enemies/ugg/updx1.png");
  imgUgg[0][1] = loadImage("assets/images/enemies/ugg/updx1.png");
  imgUgg[1][0] = loadImage("assets/images/enemies/ugg/upsx0.png");
  imgUgg[1][1] = loadImage("assets/images/enemies/ugg/upsx1.png");
  
  
  //Sounds
  soundInsertCoin = new SoundFile(this, "assets/sounds/coin.wav");
  soundBonus = new SoundFile(this, "assets/sounds/bonus.wav");
  soundJump = new SoundFile(this, "assets/sounds/jump.wav");
  soundJumpSnake = new SoundFile(this, "assets/sounds/jumpSnake.wav");
  soundJumpBall = new SoundFile(this, "assets/sounds/jumpBall.wav");
  soundJumpSlick = new SoundFile(this, "assets/sounds/jumpSlick.wav");
  soundCaught = new SoundFile(this, "assets/sounds/caught.wav");
  soundFall = new SoundFile(this, "assets/sounds/fall.wav");
  soundSnakeFall = new SoundFile(this, "assets/sounds/snakeFall.wav");
  soundWin = new SoundFile(this, "assets/sounds/win.wav");
  soundMenu = new SoundFile(this, "assets/sounds/menu.wav");
  soundGameOver = new SoundFile(this, "assets/sounds/gameOver.wav");
  soundUgg = new SoundFile(this, "assets/sounds/ugg.wav");
  
  
  //Initialize
  firstInitialize();
}




//INITIALIZE
void firstInitialize(){
  menu = false;
  
  //Scenes
  start = false;
  startScene = true;
  menuScene = false;
  gameScene = false;
  winScene = false;
  loseScene = false;
  collisionScene = false;
  choiceScene = false;
  
  
  //UI
  iCabinCruiser = 0;
  cabinCruiserY = 0;
  cabinCruiserW = 181;
  cabinCruiserH = 320;
  
  
  //Score
  bestScore = 0;
  
  
  //Cube
  for(int i=0; i<28; i++) cube[i] = new Cube();
  
  cubePos[0][0] = 256;
  cubePos[0][1] = 144;
  cubePos[1][0] = 224;
  cubePos[1][1] = 192;
  cubePos[2][0] = 288;
  cubePos[2][1] = 192;
  cubePos[3][0] = 192;
  cubePos[3][1] = 240;
  cubePos[4][0] = 256;
  cubePos[4][1] = 240;
  cubePos[5][0] = 320;
  cubePos[5][1] = 240;
  cubePos[6][0] = 160;
  cubePos[6][1] = 288;
  cubePos[7][0] = 224;
  cubePos[7][1] = 288;
  cubePos[8][0] = 288;
  cubePos[8][1] = 288;
  cubePos[9][0] = 352;
  cubePos[9][1] = 288;
  cubePos[10][0] = 128;
  cubePos[10][1] = 336;
  cubePos[11][0] = 192;
  cubePos[11][1] = 336;
  cubePos[12][0] = 256;
  cubePos[12][1] = 336;
  cubePos[13][0] = 320;
  cubePos[13][1] = 336;
  cubePos[14][0] = 384;
  cubePos[14][1] = 336;
  cubePos[15][0] = 96;
  cubePos[15][1] = 384;
  cubePos[16][0] = 160;
  cubePos[16][1] = 384;
  cubePos[17][0] = 224;
  cubePos[17][1] = 384;
  cubePos[18][0] = 288;
  cubePos[18][1] = 384;
  cubePos[19][0] = 352;
  cubePos[19][1] = 384;
  cubePos[20][0] = 416;
  cubePos[20][1] = 384;
  cubePos[21][0] = 64;
  cubePos[21][1] = 432;
  cubePos[22][0] = 128;
  cubePos[22][1] = 432;
  cubePos[23][0] = 192;
  cubePos[23][1] = 432;
  cubePos[24][0] = 256;
  cubePos[24][1] = 432;
  cubePos[25][0] = 320;
  cubePos[25][1] = 432;
  cubePos[26][0] = 384;
  cubePos[26][1] = 432;
  cubePos[27][0] = 448;
  cubePos[27][1] = 432;
  
  
  //Enemies
  //Balls
  for(int i=0; i<3; i++){
    ball[i] = new Ball();
  }
  
  //Green Balls
  greenBall = new GreenBall();
}


void initialize(){
  //Scenes
  winCond = 0;
  timeToLose = 0;
  timeToWin = 0;
  startScene = false;
  menuScene = false;
  gameScene = true;
  winScene = false;
  loseScene = false;
  collisionScene = false;
  choiceScene = false;
  
  
  //HUD
  timeToPlayer = 0;
  
  
  //Score & Levels
  lvl = 1;
  score = 0;
  
  
  //Cube
  for(int i=0; i<28; i++) cube[i].init(cubePos[i][0], cubePos[i][1], false);
  
  
  //Bonus
  for(int i=0; i<2; i++) bonus[i] = new Bonus();
  
  bonusPos[0][0] = 96;
  bonusPos[0][1] = 276;
  bonusPos[1][0] = 416;
  bonusPos[1][1] = 276;
  
  for(int i=0; i<2; i++) bonus[i].init(bonusPos[i][0], bonusPos[i][1], false, false);
  
  stopTime = false;
  
  
  //qBert
  qBert.init();
  qBert.lives = 4;
  
  
  //Enemies
  //Snake
  snake.init();
  timeToSpawnSnake = 0;
  snakeAlive = false;
  
  //Ugg
  ugg.init();
  timeToSpawnUgg = 0;
  uggAlive = false;
  
  //Balls
  for(int i=0; i<3; i++){
    ball[i].init();
    ballAlive[i] = false;
  }
  timeToSpawnBall = 0;
  ballCount = 0;
  
  //Green Balls
  greenBall.init();
  greenBallAlive = false;
  timeToSpawnGreenBall = 0;
  
  //Sam
  sam.init();
  timeToSpawnSam = 0;
  samAlive = false;
  
  //Slick
  slick.init();
  timeToSpawnSlick = 0;
  slickAlive = false;
}


void initializeLvl(){
  //Scenes
  winCond = 0;
  timeToLose = 0;
  timeToWin = 0;
  startScene = false;
  menuScene = false;
  gameScene = true;
  winScene = false;
  loseScene = false;
  collisionScene = false;
  choiceScene = false;
  
  
  //HUD
  timeToPlayer = 0;
  
  
  //Cube
  for(int i=0; i<28; i++) cube[i].init(cubePos[i][0], cubePos[i][1], false);
  
  
  //Bonus
  for(int i=0; i<2; i++) bonus[i] = new Bonus();
  
  bonusPos[0][0] = 96;
  bonusPos[0][1] = 276;
  bonusPos[1][0] = 416;
  bonusPos[1][1] = 276;
  
  for(int i=0; i<2; i++) bonus[i].init(bonusPos[i][0], bonusPos[i][1], false, false);
  
  stopTime = false;
  
  
  //qBert
  qBert.init();
  
  
  //Enemies
  //Snake
  snake.init();
  timeToSpawnSnake = 0;
  snakeAlive = false;
  
  //Ugg
  ugg.init();
  timeToSpawnUgg = 0;
  uggAlive = false;
  
  //Balls
  for(int i=0; i<3; i++){
    ball[i].init();
    ballAlive[i] = false;
  }
  timeToSpawnBall = 0;
  ballCount = 0;
  
  //Green Balls
  greenBall.init();
  greenBallAlive = false;
  timeToSpawnGreenBall = 0;
  
  //Sam
  sam.init();
  timeToSpawnSam = 0;
  samAlive = false;
  
  //Slick
  slick.init();
  timeToSpawnSlick = 0;
  slickAlive = false;
}




//FUNCTIONS
void drawStart(){
  if(start){
    if(iCabinCruiser<64){
      image(cabinCruiser, width/2, height/2+cabinCruiserY, cabinCruiserW, cabinCruiserH);
      cabinCruiserY+=4.5;
      cabinCruiserW+=iCabinCruiser*1;
      cabinCruiserH+=iCabinCruiser*1.76;
      iCabinCruiser++;
    }
    
    if(iCabinCruiser==64){
      menuScene = true;
      startScene = false;
    }
  }
  
  if(start==false){
    pushMatrix();
    fill(255);
    textSize(16);
    text("ORIGINAL KEYS", width/2-128, 128);
    text("KEYBOARDS KEYS", width/2+128, 128);
    text("^", width/2-128, 156);
    text("|", width/2-128, 160);
    text("W", width/2+128, 160);
    text("<", width/2-132, 176);
    text("-", width/2-128, 176);
    text("A", width/2+128, 176);
    pushMatrix();
    translate(width/2, height/2+156);
    rotate(PI);
    text("^", width/2-128, 196);
    popMatrix();
    text("|", width/2-128, 192);
    text("S", width/2+128, 192);
    text(">", width/2-124, 208);
    text("-", width/2-128, 208);
    text("D", width/2+128, 208);
    textSize(32);
    text("PRESS ENTER", width/2, 320);
    text("TO INSERT COIN", width/2, 352);
    popMatrix();
    
    if(keyCode==ENTER){
      start = true;
      keyCode = TAB;
      soundInsertCoin.play();
    }
  }
}


void drawMenu(){
  if(menu==false){
    soundMenu.play();
    menu = true;
  }
  image(title, width/2, 96, 368, 56);
  
  pushMatrix();
  fill(255);
  textSize(32);
  text("PLAY SELECT", width/2, height/2-64);
  text("PLAYER", width/2-10, height/2-16);
  text("PLAYERS", width/2, height/2+16);
  fill(255, 0, 0);
  text("1", width/2-104, height/2-16);
  text("2", width/2-104, height/2+16);
  fill(255);
  textSize(16);
  text("KONAMI INDUSTRY CO. , LTD.", width/2, height/2+64);
  text("LICENSED BY", width/2, height/2+80);
  text("NINTENDO OF AMERICA INC.", width/2, height/2+96);
  text("ULTRA GAMES IS A REGISTERED", width/2, height-56);
  text("TRADEMARK OF ULTRA SOFTWARE", width/2, height-40);
  text("CORPORATION", width/2, height-24);
  popMatrix();
  
  if(keyPressed){
        if(key=='w' || key=='W')
          choicePlayer = 0;
          
        if(key=='s' || key=='S')
          choicePlayer = 1;
  }
  
  if(choicePlayer==0)
    image(imgQBert[0][0], width/2-140, height/2-16);
  if(choicePlayer==1)
    image(imgQBert[0][0], width/2-140, height/2+16);
  
  if(keyCode == ENTER){
    soundMenu.stop();
    initialize();
    keyCode = TAB;
  }
}


void drawGame(){
  //Cube
  for(int i=0; i<28; i++) cube[i].drawCube();
  
  //Bonus
  for(int i=0; i<2; i++) bonus[i].drawBonus();
  
  //qBert
  qBert.qBertMovement();
  
  //HUD
  drawHUD();
  
  //Enemies
  if(stopTime==false)
    enemiesSpawn();
  
  if(stopTime){
    //Snake
    if(snakeAlive){
      if(snake.snakeBall)
        image(imgSnakeBall[0], snake.x, snake.y);
        
      if(snake.snakeSnake)
        image(imgSnake[snake.randomSpawn][0], snake.x, snake.y);
    }
    
    //Ugg
    if(uggAlive)
      image(imgUgg[ugg.randomSpawn][0], ugg.x, ugg.y);
    
    //Balls
    for(int i=0; i<3; i++)
      if(ballAlive[i])
        image(ball[i].imgBall[0], ball[i].x, ball[i].y);
        
    //Sam
    if(samAlive)
      image(sam.imgSam[sam.imgSamSet[0]][sam.imgSamSet[1]], sam.x, sam.y);
        
    //Slick
    if(slickAlive)
      image(slick.imgSlick[slick.r][0], slick.x, slick.y);
      
      
    timeToStop++;
    
    if(timeToStop==64){
      stopTime = false;
    }
    
  }
}


void drawHUD(){
  if(timeToPlayer<6)
    image(playerTitle[timeToPlayer], 64, 32);
    timeToPlayer++;
  
  if(timeToPlayer==6)
    timeToPlayer = 0;
    
  image(playerNumberTitle[choicePlayer], 128, 28);
  pushMatrix();
  fill(255, 255, 0);
  textSize(16);
  text(nf(score, 7), 50, 48);
  fill(255, 255, 0);
  textSize(16);
  text(" = " + qBert.lives, 48, 96);
  textSize(24);
  fill(255,0,0);
  text("LEVEL " + lvl, width-96, 32);
  popMatrix();
  image(changeToTitle, 60, 64);
  image(lifeTitle, 24, 96);
  if(lvl<5)
    image(changeToCube[lvl-1], 128, 64);
}


void drawWin(){
  if(timeToWin==0) soundWin.play();
  
  if(timeToWin<32){
    if(timeToWin%2==0){
      for(int i=0; i<28; i++){
        cube[i].cubeColor = false;
        cube[i].drawCube();
      }
    }
    
    if(timeToWin%2==1){
      for(int i=0; i<28; i++){
        cube[i].cubeColor = true;
        cube[i].drawCube();
      }
    }
    
    drawHUD();
    timeToWin++;
  }
  
  if(timeToWin==32){
    lvl++;
    initializeLvl();
  }
}


void drawLose(){
  if(timeToLose==0 && lvl<5)
    soundGameOver.play();
  
  if(timeToLose<48 && lvl<5){
    pushMatrix();
    fill(255);
    textSize(32);
    text("GAME OVER", width/2, height/2);
    popMatrix();
    
    timeToLose++;
  }
  
  if(timeToLose<48 && lvl==5){
    pushMatrix();
    fill(255);
    textSize(32);
    text("YOU WIN", width/2, height/2);
    popMatrix();
    
    timeToLose++;
  }
  
  if(timeToLose==48){
    pushMatrix();
    textSize(32);
    fill(255,0,0);
    text("BEST SCORE " + bestScore, width/2, height/2-48);
    fill(255,255,0);
    text("YOUR SCORE " + score, width/2, height/2-16);
    fill(255);
    text("PRESS ENTER", width/2, height/2+32);
    text("TO CONTINUE...", width/2, height/2+64);
    popMatrix();
    if(keyCode==ENTER){
      keyCode = TAB;
      loseScene = false;
      choiceScene = true;
    }
  }
}


void drawChoice(){
  pushMatrix();
    fill(255);
    textSize(32);
    text("CONTINUE X", width/2, height/2-32);
    text("GAME END Z", width/2, height/2+32);
    popMatrix();
    if(keyPressed){
        if(key == 'x' || key=='X')
          initialize();
        if(key == 'z' || key=='Z'){
          menu = false;
          qBert.lives = 4;
          choiceScene = false;
          menuScene = true;
        }
    }
}


void drawCollision(){
  if(timeToCollision==0) soundCaught.play();
  
  if(timeToCollision<32){
    //Cube
    for(int i=0; i<28; i++) cube[i].drawCube();
    
    //Bonus
    for(int i=0; i<2; i++) bonus[i].drawBonus();
    
    
    //qBert
    image(imgQBert[qBert.qBertValue][0], qBert.x, qBert.y);
    image(imgCaught, qBert.x+16, qBert.y-48);
    
    //HUD
    drawHUD();
  }
  
  if(timeToCollision==32){
    qBert.lives--;
    
    if(qBert.lives>=0){
      timeToSpawnSnake = 0;
      snakeAlive = false;
     
      timeToSpawnUgg = 0;
      uggAlive = false;
      
      timeToSpawnBall = 0;
      for(int i=0; i<3; i++)
        ballAlive[i] = false;
        
      timeToSpawnGreenBall = 0;
      greenBallAlive = false;
      
      timeToSpawnSam = 0;
      samAlive = false;
      
      timeToSpawnSlick = 0;
      slickAlive = false;
      
      qBert.x = cubePos[0][0];
      qBert.y = cubePos[0][1]-28;
      qBert.qBertValue = 1;
      qBert.init();
    }
    
    collisionScene = false;
    if(qBert.lives>=0)
      gameScene = true;
    else{
      if(score>bestScore)
        bestScore = score;
      loseScene = true;
    }
  }
  
  timeToCollision++;
}




//DRAW
void draw(){
  background(0);
  
  if(startScene)
    drawStart();
  if(menuScene)
    drawMenu();
  if(gameScene){
    for(int i=0; i<2; i++)
      if(bonus[i].bonusIsUsing && bonus[i].timeToAnimation<16)
        background(0,255,0);
        
    if(stopTime){
      rR = int(random(0,255));
      rG = int(random(0,255));
      rB = int(random(0,255));
      background(rR,rG,rB);
    }
    drawGame();
    updateScenes();
    if(stopTime==false)
      updateCollision();
  }
  if(winScene)
    drawWin();
  if(loseScene)
    drawLose();
  if(collisionScene)
    drawCollision();
  if(choiceScene)
    drawChoice();
}
