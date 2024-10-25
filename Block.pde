class Block {
  private PVector pos;
  private PImage img = loadImage("block.png");
  private final int WIDTH = img.width;
  private final int HEIGHT = img.height;
  private PVector v;
  boolean isActive;
  Block(float x, float y, int vx, int vy, boolean isActive) {
    pos = new PVector(x, y);
    v = new PVector(vx, vy);
    this.isActive = isActive;
  }

  void draw() {
    fill(255, 0, 0);
    pos.x += v.x;
    pos.y += v.y;

    if (pos.x <= 0 || width <= pos.x+WIDTH) {
      v.x = -v.x;
    }
    if (pos.y <= 100 || 300 <= pos.y) {
      v.y = -v.y;
    }
    rect(pos.x, pos.y, WIDTH, HEIGHT);
    image(img, pos.x, pos.y);
  }


  void update() {
  }
  PVector getPos() {
    return pos;
  }
  int getW() {
    return WIDTH;
  }
  int getH() {
    return HEIGHT;
  }
}
