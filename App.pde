int count = 0;
int setEventNum = -1;
void keyPressed() {
  if (keyCode == SHIFT) {
    if (scene == 0) {//title
      println("shiftスタート");
      setEventNum = 0;
    } else if (scene == 1) {//gameScene
      setEventNum = 1;
    } else if (scene == 2) {//gameOver
      setEventNum = 2;
    } else if (scene == 3) {//gameClear
      setEventNum = 3;
    }
  } else if (keyCode == ENTER) {
    if (scene == 0) {
    } else if (scene == 1) {
    } else if (scene == 2) {
    } else if (scene == 3) {
    }
  } else if (key =='0') {
    if (scene == 1) {
      //gameScene.blockBullets.remove(i);
      player.isActive = false;
      scene = 2;
      sound.stop();
      sound.burst();
      sound.gameOver();
      manageGame.stop();
    }
  } else if (key =='1') {
    if (scene == 1) {
      setStage(1);
    }
  } else if (key =='2') {
    if (scene == 1) {
      setStage(2);
    }
  } else if (key =='3') {
    if (scene == 1) {
      setStage(3);
    }
  } else if (key =='4') {
    if (scene == 1) {
      setStage(4);
    }
  } else if (key =='5') {
    if (scene == 1) {
      setStage(5);
    }
  } else if (key == '6') {//デモ用コマンド
    if (scene == 1) {
      setEventNum = 4;
    }
  } else if (key == '7') {
    if (scene == 1) {
      setStage(7);
    }
  } else if (key == '8') {
    if (scene == 1) {
      setStage(8);
    }
  }
}
void setDefault() {
  player.isActive = true;
  for (int i = 0; i < block.length; i++) {
    block[i].isActive = true;
  }
}

void setStage(int stage) {
  println(stage);
  if (stage <= 7) {
    clearParticle.drawing(width/2.0, height/2.0);
  } else if (stage == 8) {
    particleRainbow.drawing(width/2.0, height/2.0);
  }
  gameScene = new GameScene(stage);
  gameScene.setup();
  sound.enter();
}
int countGameSound = 0;
void loopGameSound() {
  int count = gameScene.getCount();
  //println(count);
  if (count % (10200-45) == 0 && count != 0) {//2:50秒
    println("ゲームBGM");
    sound.stop();
    sound.game();
  }
}

void enterGame() {
  sound.stop();
  sound.enter();
  gameScene = new GameScene(1);
  scene = 1;
  gameScene.setup();
  sound.game();
  manageGame.start();
}
