void updateCollision(){
  //Snake
  if(qBert.x==snake.x && qBert.y==snake.y+12 && snakeAlive){
    timeToCollision = 0;
    gameScene = false;
    collisionScene = true;
  }
  
  //Ugg
  if(qBert.x==ugg.x && qBert.y==ugg.y && uggAlive){
    timeToCollision = 0;
    gameScene = false;
    collisionScene = true;
  }
  
  
  for(int i=0; i<3; i++){
    //Balls
    if(qBert.x==ball[i].x && qBert.y==ball[i].y && ballAlive[i]){
      timeToCollision = 0;
      gameScene = false;
      collisionScene = true;
    }
    
    //Green Balls
    if(qBert.x==greenBall.x && qBert.y==greenBall.y-4 && greenBallAlive){
      greenBallAlive = false;
      timeToStop = 0;
      stopTime = true;
    }
  }
  
  //Sam
  if(qBert.x==sam.x && qBert.y==sam.y && samAlive){
    timeToSpawnSam = 0;
    samAlive = false;
  }
  
  //Slick
  if(qBert.x==slick.x && qBert.y==slick.y && slickAlive){
    timeToCollision = 0;
    gameScene = false;
    collisionScene = true;
  }
}
