class GameOver {
  PImage background = loadImage("gameOver.png");
  GameOver() {
  }
  void draw() {
    image(background, 0, 0);
    textAlign(LEFT, TOP);
    fill(255, 0, 0);
    textSize(70);
    text(manageGame.getTime(), 630, 650);
    text(gameScene.getStage(), 630, 840);
  }
}
