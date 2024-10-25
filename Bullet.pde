class Bullet {
  private PVector pos;
  private PImage img = loadImage("blueBook.png");
  private PImage img2 = loadImage("redBook.png");
  float vy;
  int type;
  final float WIDTH = img.width * 0.9;
  final float HEIGHT = img.height * 0.9;
  Bullet(float x, float y, float vy, int type) {
    if (type == 0) {
      x = x + (player.getW()/2.0) - (WIDTH/2.0);
    }
    pos = new PVector(x, y);
    this.vy = vy;
    this.type = type;
  }
  void draw() {
    pos.y += vy;
    if (type == 0) {
      fill(255);
      image(img, pos.x, pos.y);
      player.reclining();
    } else if (type == 1) {
      fill(255, 0, 0);
      image(img2, pos.x, pos.y);
      //rect(pos.x, pos.y, WIDTH, HEIGHT);
    }
  }

  boolean isActive() {
    return (0 <= pos.y + 20)&&(pos.y <= height) ;
  }

  PVector getPos() {
    return pos;
  }

  float getW() {
    return WIDTH;
  }
  float getH() {
    return HEIGHT;
  }
}
