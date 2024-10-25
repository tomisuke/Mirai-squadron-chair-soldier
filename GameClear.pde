boolean checkClear() {
  for (int i = 0; i < block.length; i++) {
    if (block[i].isActive == true) {//ブロックが1つでもアクティブの場合､クリアしていないためfalseを返す
      return false;
    }
    if (bossBlock.isActive == true) {//ボスブロックがアクティブの場合､クリアしていないためfalseを返す
      return false;
    }
  }
  return true;//すべてアクティブでないなら､クリアしているためtrueを返す
}

class GameClear {
  PImage background = loadImage("clear.png");
  private int count;
  GameClear() {
  }
  void draw() {
    image(background,0,0);
    textSize(70);
    textAlign(LEFT, TOP);
    fill(0, 255, 0);
    text(manageGame.getTime(), 570, 700);
    count++;
    if (count == 200) {
      sound.gameClear2();
    }
  }
}
