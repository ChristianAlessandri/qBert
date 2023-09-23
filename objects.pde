public class Cube{
  public float x, y;
  public boolean cubeColor;
  
  
  public void init(float x, float y, boolean cubeColor){
    this.x = x;
    this.y = y;
    this.cubeColor = cubeColor;
  }
  
  
  public void drawCube(){
    if(lvl<5){
      if(cubeColor)
        image(imgCube[((lvl-1)*2)+1], x, y);
        
      if(cubeColor == false)
        image(imgCube[(lvl-1)*2], x, y);
    }
  }
}




public class Bonus{
  public int timeToAnimation;
  public float x, y;
  public boolean bonusIsUsing, bonusUsed;
  private int iBonusAnimation = 0;
  
  
  public void init(float x, float y, boolean bonusIsUsing, boolean bonusUsed){
    this.x = x;
    this.y = y;
    this.bonusIsUsing = bonusIsUsing;
    this.bonusUsed = bonusUsed;
  }
  
  
  public void drawBonus(){
    if(bonusIsUsing) animationBonusIsUsing();
    if(bonusUsed==false) animationBonus();
  }
  
  
  public void animationBonusIsUsing(){
    if(timeToAnimation==0)
      soundBonus.play();
      
    if(timeToAnimation==16){
      //Snake
      timeToSpawnSnake = 0;
      snakeAlive = false;
      
      //Ugg
      timeToSpawnUgg = 0;
      uggAlive = false;
      
      //Balls
      timeToSpawnBall = 0;
      for(int i=0; i<3; i++)
        ballAlive[i] = false;
      
      //Sam
      timeToSpawnSam = 0;
      samAlive = false;
      
      //Slick
      timeToSpawnSlick = 0;
      slickAlive = false;
    }
    
    if(timeToAnimation<32){
      qBert.canJump = false;
      if(x<256)
        x+=5;
        
      if(x>256)
        x-=5;
      
      y-=5.625;
      qBert.x = x;
      qBert.y = y-16;
      image(imgQBert[qBert.qBertValue][0], qBert.x, qBert.y);
      
      animationBonus();
      
      timeToAnimation++;
    }
    
    if(timeToAnimation==32){
      qBert.timeToFall = 0;
      qBert.qBertFall = true;
    }
    
    if(timeToAnimation>=32 && timeToAnimation<64){
      y-=3;
      
      animationBonus();
      
      timeToAnimation++;
    }
    
    if(timeToAnimation==64){
      score += 500;
      bonusIsUsing = false;
    }
  }
  
  
  public void animationBonus(){
    image(imgBonus[iBonusAnimation], x, y);
    if(iBonusAnimation<16) iBonusAnimation++;
    if(iBonusAnimation==16) iBonusAnimation = 0;
  }
}




public class QBert{
  public int lives;
  public int qBertValue;
  public int timeToJump, timeToFall, timeToFallOut;
  public boolean canJump;
  public boolean qBertFall = false;
  public boolean qBertOnBlock = true;
  public boolean qBertOnBonus = false;
  public float x, y;
  private float xV = 4;
  private float yV = 6;
  
  
  public void init(){
    this.qBertValue = 1;
    this.canJump = true;
    this.x = cubePos[0][0];
    this.y = cubePos[0][1]-28;
  }
  
  
  public void qBertMovement(){
    if(keyPressed && canJump){
      if(key == 'w' || key=='W'){
        qBertValue = 0;
        timeToJump = 0;
        canJump = false;
      }
      
      if(key == 'd' || key=='D'){
        qBertValue = 1;
        timeToJump = 0;
        canJump = false;
      }
      
      if(key == 's' || key=='S'){
        qBertValue = 2;
        timeToJump = 0;
        canJump = false;
      }
      
      if(key == 'a' || key=='A'){
        qBertValue = 3;
        timeToJump = 0;
        canJump = false;
      }
    }
    
    if(qBertOnBlock || qBertOnBonus){
      if(canJump) image(imgQBert[qBertValue][0], x, y);
      if(canJump == false)
        if(qBertFall) qBertFall(); 
        else qBertJump();
    }
    
    if(qBertOnBlock == false && qBertOnBonus == false)
      qBertFallOut();
  }
  
  
  public void qBertJump(){
    if(timeToJump==0) soundJump.play();
    
    if(timeToJump<4){
      if(qBertValue==0){
        x += xV;
        y -= yV*4;
      }
      
      if(qBertValue==1){
        x += xV;
        y -= yV*2;
      }
      
      if(qBertValue==2){
        x -= xV;
        y -= yV*2;
      }
      
      if(qBertValue==3){
        x -= xV;
        y -= yV*4;
      }
      
      image(imgQBert[qBertValue][1], x, y);
    }
    
    if(timeToJump>=4 && timeToJump<8){
      if(qBertValue==0){
        x += xV;
        y += yV*2;
      }
      
      if(qBertValue==1){
        x += xV;
        y += yV*4;
      }
      
      if(qBertValue==2){
        x -= xV;
        y += yV*4;
      }
      
      if(qBertValue==3){
        x -= xV;
        y += yV*2;
      }
      
      image(imgQBert[qBertValue][1], x, y);
    }
    
    if(timeToJump==8){
      cubeControl();
      bonusControl();  
    }
    
    if(timeToJump>=8){
      image(imgQBert[qBertValue][0], x, y);
    }
    
    if(timeToJump==12){
      canJump = true;
    }
    
    
    timeToJump++;
  }
  
  
  public void qBertFall(){
    if(timeToFall<8){
      y+=4.5;
      image(imgQBert[qBertValue][1], x, y);
      
      timeToFall++;
    }
    
    if(timeToFall==8){
      cubeControl();
      qBertFall = false;
      canJump = true;
    }
  }
  
  
  public void qBertFallOut(){
    if(timeToFallOut==0){
      soundFall.play();
      snake.canJump = false;
      snake.snakeSnake = false;
      snakeAlive = false;
    }
    
    if(timeToFallOut<16){
      y+=32;
      image(imgQBert[qBertValue][1], x, y);
      for(int i=0; i<28; i++) cube[i].drawCube();
          
    }
    
    if(timeToFallOut==16){
      qBertOnBlock = true;
      lives--;
      if(lives>=0){
        timeToSpawnSnake = 0;
        for(int i=0; i<3; i++){
          timeToSpawnBall = 0;
          ballAlive[i] = false;
        }
        timeToSpawnGreenBall = 0;
        greenBallAlive = false;
        timeToSpawnSlick = 0;
        slickAlive = false;
        
        x = cubePos[0][0];
        y = cubePos[0][1]-28;
        qBertValue = 1;
        image(imgQBert[qBertValue][0], x, y);
      } 
    }
    
    timeToFallOut++;
  }
  
  
  public void cubeControl(){
    boolean cubeControl = false;
    for(int i=0; i<28; i++)
      if(x==cubePos[i][0] && y+28==cubePos[i][1]){
        cubeControl = true;
        if(cube[i].cubeColor==false){
          score+=30;
          cube[i].cubeColor = true;
        }
      }
    
    if(cubeControl)
      qBertOnBlock = true;
      
    if(cubeControl==false){
      qBertOnBlock = false;
      timeToFallOut = 0;
    }
  }
  
  
  public void bonusControl(){
    boolean bonusControl = false;
    for(int i=0; i<2; i++)
      if(bonus[i].bonusUsed == false && x==bonus[i].x && y==bonus[i].y-16){
        bonusControl = true;
        bonus[i].timeToAnimation = 0;
        bonus[i].bonusUsed = true;
        bonus[i].bonusIsUsing = true;
      }
      
    if(bonusControl)
      qBertOnBonus = true;
    if(bonusControl==false){
      qBertOnBonus = false;
      timeToFallOut = 0;
    }
  }
}
