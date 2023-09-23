void updateScenes(){
  //lvl++
  winCond = 0;
  for(int i=0; i<28; i++){
    if(cube[i].cubeColor){
      winCond++;
    }
    
    if(winCond==28){
      if(score>bestScore)
        bestScore = score;
      
      gameScene = false;
      winScene = true;
    }
  }
  
  
  //Win & Lose
  if(qBert.lives<0 || lvl==5){
    if(score>bestScore)
      bestScore = score;
    
    gameScene = false;
    loseScene = true;
  }
}
