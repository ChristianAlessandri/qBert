void enemiesSpawn(){
  //Balls
  for(int i=0; i<3; i++){
    timeToSpawnBall++;
    
    if(ball[i].outMap)
      ballAlive[i] = false;
    if(ballAlive[i])
      ball[i].drawBall();
      
    if(timeToSpawnBall==(i+1)*80 && ballAlive[ballCount]==false){
      ballAlive[ballCount] = true;
      ball[ballCount].init();
      ballCount++;
      if(ballCount>2) ballCount = 0;
    }
      
    if(timeToSpawnBall==240)
      timeToSpawnBall = 0;
  }
  
  
  //Snake
  if(snakeAlive==false && timeToSpawnSnake<48)
    timeToSpawnSnake++;
    
  if(snakeAlive==false && timeToSpawnSnake==48){
    timeToSpawnSnake = 0;
    snakeAlive = true;
    snake.init();
  }
  
  if(snakeAlive)
    snake.drawSnake();
  
  //Ugg
  if(lvl>1){
    if(uggAlive==false && timeToSpawnUgg<48)
      timeToSpawnUgg++;
      
    if(uggAlive==false && timeToSpawnUgg==48){
      timeToSpawnUgg = 0;
      uggAlive = true;
      ugg.init();
    }
    
    if(uggAlive)
      ugg.drawUgg();
  }
  
  
  if(lvl>2){
    
  }
  
  
  if(lvl>2){
    //Green Balls
    timeToSpawnGreenBall++;
    
    if(greenBall.outMap)
      greenBallAlive = false;
    if(greenBallAlive)
      greenBall.drawGreenBall();
      
    if(timeToSpawnGreenBall==96 && greenBallAlive==false){
      greenBallAlive = true;
      greenBall.init();
    }
      
    if(timeToSpawnGreenBall==96)
      timeToSpawnGreenBall = 0;
      
    
    //Sam
    timeToSpawnSam++;
    
    if(sam.outMap)
      samAlive = false;
    if(samAlive)
      sam.drawSam();
      
    if(timeToSpawnSam==96 && samAlive==false){
      samAlive = true;
      sam.init();
    }
      
    if(timeToSpawnSam==256)
      timeToSpawnSam = 0;
      
  }
  
  
  //Slick
  if(lvl>3){
    timeToSpawnSlick++;
    
    if(slick.outMap)
      slickAlive = false;
    if(slickAlive)
      slick.drawSlick();
      
    if(timeToSpawnSlick==128 && slickAlive==false){
      slickAlive = true;
      slick.init();
    }
      
    if(timeToSpawnSlick==128)
      timeToSpawnSlick = 0;
  }
}
