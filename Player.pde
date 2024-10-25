class Player {
  private PVector pos;
  private float oldX;
  private int imageNum = 0;
  private long recliningTime = 0;
  private boolean isReclining = false;
  private PImage[] chairs = new PImage[] {
    loadImage("chair00.png"), //背面
    loadImage("chair01.png"), //右
    loadImage("chair02.png"), //正面
    loadImage("chair03.png"), //左
  };
  private PImage chairReclining =  loadImage("chairRecrining.png");
  private PImage rotateLeft = loadImage("rotateLeft.png");
  private PImage rotateRight = loadImage("rotateRight.png");
  private final float WIDTH = chairs[0].width * 0.8;
  private final float HEIGHT = chairs[0].height;
  boolean isActive;
  Player(float x, boolean isActive) {
    float y = height - (HEIGHT + 30);
    pos = new PVector(x, y);
    this.isActive = isActive;
    oldX = pos.x;
  }

  void draw() {
    if (isActive) {
      fill(0, 0, 255);
      if (!isReclining) {
        image(chairs[imageNum], pos.x - (chairs[0].width/2.0), pos.y);
      } else {
        image(chairReclining, pos.x - (chairs[0].width/2.0), pos.y);
      }
      if (frameCount % 4 == 0) {
        rotatePlayer();
        if (imageNum == 1) {
          image(rotateRight, pos.x - (rotateRight.width/2.0), pos.y + 10);
        } else if (imageNum == 3) {
          image(rotateLeft, pos.x - (rotateLeft.width/2.0), pos.y + 10);
        }
      }
      if (isReclining && millis() - recliningTime >= 300) {
        isReclining = false;
      }
    }
  }
  void rotatePlayer() {
    if (pos.x - oldX >= 5) {//右に動いたら
      isReclining = false;
      imageNum++;
      if (imageNum > 3) {
        imageNum = 0;
      }
    } else if (pos.x - oldX <= -5) {//左に動いたら
      isReclining = false;
      imageNum--;
      if (imageNum < 0) {
        imageNum = 3;
      }
    } else {//動かなかったら(少ししか動かなかったら)
      imageNum = 0;
    }
  }
  void update() {
    oldX = pos.x;
    followMouse();
  }

  void followMouse() {
    pos.x = constrain(mouseX - WIDTH/2.0, 0, width-WIDTH);
  }
  void reclining() {
    isReclining = true;
    recliningTime = millis();
  }

  boolean getIsActive() {
    return isActive;
  }
  PVector getPos() {
    return new PVector(pos.x -(WIDTH/2.0), pos.y + 50);//当たり判定の座標調整
  }
  float getW() {
    return WIDTH;
  }
}
