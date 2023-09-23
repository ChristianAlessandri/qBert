public class Snake{
  public int randomSpawn;
  public int timeToJumpSnake, timeToJumpSnakeBall, timeToFall, timeToFallOutSnake;
  public int jumpAsBall;
  public int targetedBlock, thisBlock;
  public float x, y;
  public boolean snakeBall, canJump;
  public boolean snakeSnake;
  public boolean snakeOnBlock;
  public boolean snakeFall;
  private float xV = 4;
  private float yV = 6;
  
  
  public void init(){
    randomSpawn = int(random(-1, 2));
    if(randomSpawn==0){
      this.x = cubePos[1][0];
      this.y = cubePos[1][1]-76;
    }
    
    if(randomSpawn==1){
      this.x = cubePos[2][0];
      this.y = cubePos[2][1]-76;
    }
    
    this.timeToFall = 0;
    this.snakeFall = true;
    this.snakeBall = true;
    this.canJump  = false;
    this.snakeOnBlock = true;
    this.snakeSnake = false;
  }
  
  
  public void drawSnake(){
    if(snakeBall){
      if(snakeFall){
        fallSnake();
      }
      if(canJump){
        movementSnakeBall();
      }
    }
      
    if(snakeSnake){
      if(snakeOnBlock)
        AISnake();
      if(snakeOnBlock==false)
        fallOutSnake();
    }
  }
  
  
  public void fallSnake(){
    if(timeToFall<8){
      y+=4.5;
      image(imgSnakeBall[1], x, y);
    }
    
    if(timeToFall>=8 && timeToFall<=16)
      image(imgSnakeBall[0], x, y);
    
    if(timeToFall==16){
      timeToJumpSnakeBall = 0;
      jumpAsBall = 0;
      snakeFall = false;
      canJump = true;
    }
    
    timeToFall++;
  }
  
  
  public void movementSnakeBall(){
    if(timeToJumpSnakeBall==0){
      soundJumpSnake.play();
      randomSpawn = int(random(0, 2));
    }
    
    if(timeToJumpSnakeBall<4){
      
      if(randomSpawn==0){
        x += xV;
        y -= yV*2;
      }
      
      if(randomSpawn==1){
        x -= xV;
        y -= yV*2;
      }
      
      image(imgSnakeBall[1], x, y);
    }
    
    if(timeToJumpSnakeBall>=4 && timeToJumpSnakeBall<8){
      if(randomSpawn==0){
        x += xV;
        y += yV*4;
      }
      
      if(randomSpawn==1){
        x -= xV;
        y += yV*4;
      }
      
      image(imgSnakeBall[1], x, y);
    }
    
    if(timeToJumpSnakeBall>=8)
      image(imgSnakeBall[0], x, y);
    
    timeToJumpSnakeBall++;
    
    if(timeToJumpSnakeBall==20){
      timeToJumpSnakeBall = 0;
      jumpAsBall++;
    }
    
    if(jumpAsBall==5){
      timeToJumpSnake = 0;
      snakeBall = false;
      canJump = false;
      snakeSnake = true;
    }
  }
  
  
  public void AISnake(){
    if(timeToJumpSnake==0){
      for(int i=0; i<28; i++){
        if(qBert.x==cubePos[i][0] && qBert.y+28==cubePos[i][1]){
          targetedBlock = i;
        }
        if(x==cubePos[i][0] && y+40==cubePos[i][1]){
          thisBlock = i;
        }
      }
      
      if(thisBlock>targetedBlock){
        if(x>qBert.x)
          randomSpawn = 3;
        if(x<qBert.x)
          randomSpawn = 0;
      }
      
      if(thisBlock<targetedBlock){
        if(x>qBert.x)
          randomSpawn = 2;
        if(x<qBert.x)
          randomSpawn = 1;
      }
    }
    
    if(timeToJumpSnake<4){
      if(randomSpawn==0){
        x += xV;
        y -= yV*4;
      }
      
      if(randomSpawn==1){
        x += xV;
        y -= yV*2;
      }
      
      if(randomSpawn==2){
        x -= xV;
        y -= yV*2;
      }
      
      if(randomSpawn==3){
        x -= xV;
        y -= yV*4;
      }
      
      image(imgSnake[randomSpawn][1], x, y);
    }
    
    if(timeToJumpSnake>=4 && timeToJumpSnake<8){
      if(randomSpawn==0){
        x += xV;
        y += yV*2;
      }
      
      if(randomSpawn==1){
        x += xV;
        y += yV*4;
      }
      
      if(randomSpawn==2){
        x -= xV;
        y += yV*4;
      }
      
      if(randomSpawn==3){
        x -= xV;
        y += yV*2;
      }
      
      image(imgSnake[randomSpawn][1], x, y);
    }
    
    if(timeToJumpSnake==8){
      cubeControlSnake();
    }
    
    if(timeToJumpSnake>=8)
      image(imgSnake[randomSpawn][0], x, y);
    
    timeToJumpSnake++;
    
    if(timeToJumpSnake==20)
      timeToJumpSnake = 0;
  }
  
  
  public void fallOutSnake(){
    if(timeToFallOutSnake==0) soundSnakeFall.play();
    
    if(timeToFallOutSnake<16){
      y+=32;
      image(imgSnake[randomSpawn][1], x, y);
      for(int i=0; i<28; i++) cube[i].drawCube();
      image(imgQBert[qBert.qBertValue][0], qBert.x, qBert.y);
      for(int i=0; i<3; i++)
        if(ballAlive[i])
          image(ball[i].imgBall[ball[i].imgBallSet], ball[i].x, ball[i].y);
    }
    
    if(timeToFallOutSnake==16){
      snakeSnake = false;
      snakeAlive = false;
      snakeOnBlock = true;
      timeToSpawnSnake = 0;
    }
    
    timeToFallOutSnake++;
  }
  
  
  public void cubeControlSnake(){
    boolean cubeControl = false;
    for(int i=0; i<28; i++)
      if(x==cubePos[i][0] && y+40==cubePos[i][1])
        cubeControl = true;
    
    if(cubeControl)
      snakeOnBlock = true;
    if(cubeControl==false){
      snakeOnBlock = false;
      timeToFallOutSnake = 0;
    }
  }
}




public class Ugg{
  private int nJump;
  public int randomSpawn;
  public int timeToJump, timeToFall, timeToFallOut;
  public float x, y;
  public boolean fall, onBlock;
  private float xV = 4;
  private float yV = 6;
  
  
  public void init(){
    this.nJump = 0;
    
    randomSpawn = int(random(-1, 2));
    if(randomSpawn==0){
      this.x = cubePos[22][0];
      this.y = cubePos[22][1]+32;
    }
    
    if(randomSpawn==1){
      this.x = cubePos[26][0];
      this.y = cubePos[26][1]+32;
    }
    
    
    this.timeToFall = 0;
    this.timeToFallOut = 0;
    this.onBlock = false;
    this.fall = true;
  }
  
  
  public void drawUgg(){
    if(fall)
      fall();
      
    if(onBlock)
      AIUgg();
      
    if(onBlock==false && fall==false)
      fallOut();
  }
  
  
  public void fall(){
    if(timeToFall<8){
      y+=4.5;
    }
    
    if(timeToFall==8)
      soundUgg.play();
    
    if(timeToFall>=8 && timeToFall<=16)
      image(imgUgg[randomSpawn][1], x, y);
    
    if(timeToFall==16){
      timeToJump = 0;
      fall = false;
      onBlock = true;
    }
    
    timeToFall++;
  }
  
  
  public void AIUgg(){
    if(timeToJump<4){
      if(randomSpawn==0){
        x += xV;
        y += yV*2;
      }
      
      if(randomSpawn==1){
        x -= xV;
        y += yV*2;
      }
      
      image(imgUgg[randomSpawn][1], x, y);
    }
    
    if(timeToJump>=4 && timeToJump<8){
      if(randomSpawn==0){
        x += xV;
        y -= yV*4;
      }
      
      if(randomSpawn==1){
        x -= xV;
        y -= yV*4;
      }
      
      image(imgUgg[randomSpawn][1], x, y);
    }
    
    if(timeToJump>=8)
      image(imgUgg[randomSpawn][0], x, y);
    
    timeToJump++;
    
    if(timeToJump==20){
      nJump++;
      
      if(nJump>6)
        onBlock = false;
        
      if(nJump<=6)
        timeToJump = 0;
    }
  }
  
  
  public void fallOut(){
    if(timeToFallOut<16){
      y-=32;
      image(imgUgg[randomSpawn][1], x, y);
    }
    
    timeToFallOut++;
    
    if(timeToFallOut==16){
      uggAlive = false;
      timeToSpawnUgg = 0;
    }
  }
}




public class Ball{
  public int nJump;
  private int r;
  private float xV = 4;
  private float yV = 6;
  public int timeToFall;
  public int timeToJump, timeToFallOut;
  private int imgBallSet;
  private float x, y;
  public boolean outMap;
  private boolean fall;
  private boolean jump;
  private boolean fallOut;
  public PImage[] imgBall = new PImage[2];
  
  
  public void init(){
    int r = int(random(0, 2));
    if(r==0){
      this.x = cubePos[1][0];
      this.y = cubePos[1][1]-64;
    }else{
      this.x = cubePos[2][0];
      this.y = cubePos[2][1]-64;
    }
    this.imgBallSet = 0;
    this.imgBall[0] = loadImage("assets/images/enemies/ball/idle.png");
    this.imgBall[1] = loadImage("assets/images/enemies/ball/jump.png");
    this.nJump = 0;
    this.timeToFall = 0;
    this.timeToFallOut = 0;
    this.outMap = false;
    this.fall = true;
    this.jump = false;
    this.fallOut = false;
  }
  
  
  public void drawBall(){
    if(fall) fall();
    if(jump) jump();
    if(fallOut) fallOut();
    
    image(imgBall[imgBallSet], x, y);
  }
  
  
  public void fall(){
    if(timeToFall<8){
      imgBallSet = 1;
      y+=4.5;
    }
    
    if(timeToFall==8) imgBallSet = 0;
    
    if(timeToFall==16){
      timeToJump = 0;
      fall = false;
      jump = true;
    }
    
    timeToFall++;
  }
  
  
  public void jump(){
    if(timeToJump==0){
      soundJumpBall.play();
      r = int(random(0, 2));
    }
    
    if(timeToJump<4){
      if(r==0){
        x += xV;
        y -= yV*2;
      }
      
      if(r==1){
        x -= xV;
        y -= yV*2;
      }
      
      imgBallSet = 1;
    }
    
    if(timeToJump>=4 && timeToJump<8){
      if(r==0){
        x += xV;
        y += yV*4;
      }
      
      if(r==1){
        x -= xV;
        y += yV*4;
      }
      
      imgBallSet = 1;
    }
    
    if(timeToJump==8){
      imgBallSet = 0;
      nJump++;
    }
    
    timeToJump++;
    
    if(timeToJump==20) timeToJump = 0;
    
    if(nJump==6){
      jump = false;
      fallOut = true;
    }
  }
  
  
  public void fallOut(){
    if(timeToFallOut<16) y+=8;
    
    if(timeToFallOut==16){
      outMap = true;
    }
    
    timeToFallOut++;
  }
}




public class GreenBall{
  public int nJump;
  private int r;
  private float xV = 4;
  private float yV = 6;
  public int timeToFall;
  public int timeToJump, timeToFallOut;
  private int imgBallSet;
  private float x, y;
  public boolean outMap;
  private boolean fall;
  private boolean jump;
  private boolean fallOut;
  private PImage[] imgBall = new PImage[2];
  
  
  public void init(){
    int r = int(random(0, 2));
    if(r==0){
      this.x = cubePos[1][0];
      this.y = cubePos[1][1]-60;
    }else{
      this.x = cubePos[2][0];
      this.y = cubePos[2][1]-60;
    }
    this.imgBallSet = 0;
    this.imgBall[0] = loadImage("assets/images/enemies/green_ball/idle.png");
    this.imgBall[1] = loadImage("assets/images/enemies/green_ball/jump.png");
    this.nJump = 0;
    this.timeToFall = 0;
    this.timeToFallOut = 0;
    this.outMap = false;
    this.fall = true;
    this.jump = false;
    this.fallOut = false;
  }
  
  
  public void drawGreenBall(){
    if(fall) fall();
    if(jump) jump();
    if(fallOut) fallOut();
    
    image(imgBall[imgBallSet], x, y);
  }
  
  
  public void fall(){
    if(timeToFall<4){
      imgBallSet = 1;
      y+=9;
    }
    
    if(timeToFall==8) imgBallSet = 0;
    
    if(timeToFall==16){
      timeToJump = 0;
      fall = false;
      jump = true;
    }
    
    timeToFall++;
  }
  
  
  public void jump(){
    if(timeToJump==0){
      r = int(random(0, 2));
    }
    
    if(timeToJump<2){
      if(r==0){
        x += xV*2;
        y -= yV*4;
      }
      
      if(r==1){
        x -= xV*2;
        y -= yV*4;
      }
      
      imgBallSet = 1;
    }
    
    if(timeToJump>=2 && timeToJump<4){
      if(r==0){
        x += xV*2;
        y += yV*8;
      }
      
      if(r==1){
        x -= xV*2;
        y += yV*8;
      }
      
      imgBallSet = 1;
    }
    
    if(timeToJump==4){
      imgBallSet = 0;
      nJump++;
    }
    
    timeToJump++;
    
    if(timeToJump==10) timeToJump = 0;
    
    if(nJump==6){
      jump = false;
      fallOut = true;
    }
  }
  
  
  public void fallOut(){
    if(timeToFallOut<8) y+=16;
    
    if(timeToFallOut==8){
      outMap = true;
    }
    
    timeToFallOut++;
  }
}




public class Sam{
  public int nJump;
  public int r;
  private float xV = 4;
  private float yV = 6;
  public int timeToFall;
  public int timeToJump, timeToFallOut;
  public int[] imgSamSet = new int[2];
  private float x, y;
  public boolean outMap;
  private boolean fall;
  private boolean jump;
  private boolean fallOut;
  private PImage[][] imgSam = new PImage[2][2];
  
  
  public void init(){
    int r = int(random(0, 2));
    if(r==0){
      this.x = cubePos[1][0];
      this.y = cubePos[1][1]-64;
      this.imgSamSet[0] = 0;
    }else{
      this.x = cubePos[2][0];
      this.y = cubePos[2][1]-64;
      this.imgSamSet[0] = 1;
    }
    this.imgSam[0][0] = loadImage("assets/images/enemies/sam/idle_sx.png");
    this.imgSam[0][1] = loadImage("assets/images/enemies/sam/jump_sx.png");
    this.imgSam[1][0] = loadImage("assets/images/enemies/sam/idle_dx.png");
    this.imgSam[1][1] = loadImage("assets/images/enemies/sam/jump_dx.png");
    this.nJump = 0;
    this.timeToFall = 0;
    this.timeToFallOut = 0;
    this.outMap = false;
    this.fall = true;
    this.jump = false;
    this.fallOut = false;
  }
  
  
  public void drawSam(){
    if(fall) fall();
    if(jump) jump();
    if(fallOut) fallOut();
    
    image(imgSam[imgSamSet[0]][imgSamSet[1]], x, y);
  }
  
  
  public void fall(){
    if(timeToFall<8){
      imgSamSet[1] = 1;
      y+=4.5;
    }
    
    if(timeToFall==8){
      cubeControl();
      imgSamSet[1] = 0;
    }
    
    if(timeToFall==16){
      timeToJump = 0;
      fall = false;
      jump = true;
    }
    
    timeToFall++;
  }
  
  
  public void jump(){
    if(timeToJump==0){
      soundJumpSlick.play();
      r = int(random(0, 2));
    }
    
    if(timeToJump<4){
      if(r==0){
        x += xV;
        y -= yV*2;
        imgSamSet[0] = 1;
      }
      
      if(r==1){
        x -= xV;
        y -= yV*2;
        imgSamSet[0] = 0;
      }
      
      imgSamSet[1] = 1;
    }
    
    if(timeToJump>=4 && timeToJump<8){
      if(r==0){
        x += xV;
        y += yV*4;
      }
      
      if(r==1){
        x -= xV;
        y += yV*4;
      }
      
      imgSamSet[1] = 1;
    }
    
    if(timeToJump==8){
      imgSamSet[1] = 0;
      nJump++;
      cubeControl();
    }
    
    timeToJump++;
    
    if(timeToJump==20) timeToJump = 0;
    
    if(nJump==6){
      jump = false;
      fallOut = true;
    }
  }
  
  
  public void fallOut(){
    if(timeToFallOut<16) y+=8;
    
    if(timeToFallOut==16){
      outMap = true;
    }
    
    timeToFallOut++;
  }
  
  
  public void cubeControl(){
    for(int i=0; i<28; i++)
      if(x==cubePos[i][0] && y+28==cubePos[i][1]){
        if(cube[i].cubeColor==true){
          cube[i].cubeColor = false;
        }
      }
  }
}





public class Slick{
  public int nJump;
  public int r;
  private float xV = 4;
  private float yV = 6;
  public int timeToFall;
  public int timeToJump, timeToFallOut;
  private int[] imgSlickSet = new int[2];
  private float x, y;
  public boolean outMap;
  private boolean fall;
  private boolean jump;
  private boolean fallOut;
  private PImage[][] imgSlick = new PImage[2][2];
  
  
  public void init(){
    int r = int(random(0, 2));
    if(r==0){
      this.x = cubePos[1][0];
      this.y = cubePos[1][1]-64;
      this.imgSlickSet[0] = 0;
    }else{
      this.x = cubePos[2][0];
      this.y = cubePos[2][1]-64;
      this.imgSlickSet[0] = 1;
    }
    this.imgSlick[0][0] = loadImage("assets/images/enemies/slick/idle_sx.png");
    this.imgSlick[0][1] = loadImage("assets/images/enemies/slick/jump_sx.png");
    this.imgSlick[1][0] = loadImage("assets/images/enemies/slick/idle_dx.png");
    this.imgSlick[1][1] = loadImage("assets/images/enemies/slick/jump_dx.png");
    this.nJump = 0;
    this.timeToFall = 0;
    this.timeToFallOut = 0;
    this.outMap = false;
    this.fall = true;
    this.jump = false;
    this.fallOut = false;
  }
  
  
  public void drawSlick(){
    if(fall) fall();
    if(jump) jump();
    if(fallOut) fallOut();
    
    image(imgSlick[imgSlickSet[0]][imgSlickSet[1]], x, y);
  }
  
  
  public void fall(){
    if(timeToFall<8){
      imgSlickSet[1] = 1;
      y+=4.5;
    }
    
    if(timeToFall==8){
      cubeControl();
      imgSlickSet[1] = 0;
    }
    
    if(timeToFall==16){
      timeToJump = 0;
      fall = false;
      jump = true;
    }
    
    timeToFall++;
  }
  
  
  public void jump(){
    if(timeToJump==0){
      soundJumpSlick.play();
      r = int(random(0, 2));
    }
    
    if(timeToJump<4){
      if(r==0){
        x += xV;
        y -= yV*2;
        imgSlickSet[0] = 1;
      }
      
      if(r==1){
        x -= xV;
        y -= yV*2;
        imgSlickSet[0] = 0;
      }
      
      imgSlickSet[1] = 1;
    }
    
    if(timeToJump>=4 && timeToJump<8){
      if(r==0){
        x += xV;
        y += yV*4;
      }
      
      if(r==1){
        x -= xV;
        y += yV*4;
      }
      
      imgSlickSet[1] = 1;
    }
    
    if(timeToJump==8){
      imgSlickSet[1] = 0;
      nJump++;
      cubeControl();
    }
    
    timeToJump++;
    
    if(timeToJump==20) timeToJump = 0;
    
    if(nJump==6){
      jump = false;
      fallOut = true;
    }
  }
  
  
  public void fallOut(){
    if(timeToFallOut<16) y+=8;
    
    if(timeToFallOut==16){
      outMap = true;
    }
    
    timeToFallOut++;
  }
  
  
  public void cubeControl(){
    for(int i=0; i<28; i++)
      if(x==cubePos[i][0] && y+28==cubePos[i][1]){
        if(cube[i].cubeColor==true){
          cube[i].cubeColor = false;
        }
      }
  }
}
