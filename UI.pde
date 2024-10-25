class UI { //<>//
  UI() {
  }

  void level() {
    fill(255);
    textSize(80);
    textAlign(LEFT, TOP);
    text("Level" + gameScene.getStage(), 30, 20);
  }
  void time() {
    fill(255);
    textSize(80);
    textAlign(LEFT, TOP);
    text(manageGame.getTime(), 500, 20);
  }
}
