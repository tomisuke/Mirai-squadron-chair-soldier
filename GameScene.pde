Player player;
Particle particle;
Particle clearParticle;
Particle bossParticle;
ParticleRainbow particleRainbow;
//blockクラスの配列
Block[] block = new Block[10];
BossBlock bossBlock;
class GameScene {
  private PImage background = loadImage("game.jpg");
  private ArrayList<Bullet> bullets;
  private ArrayList<Bullet> blockBullets;
  private ArrayList<Bullet> bossBullets;
  ArrayList<HitService> hitService;
  private int stage;

  GameScene(int stage) {
    this.stage = stage;
  }
  void setup() {
    //gameScene関係の初期化
    bullets = new ArrayList<Bullet>();
    blockBullets = new ArrayList<Bullet>();
    bossBullets = new ArrayList<Bullet>();
    hitService = new ArrayList<HitService>();
    player = new Player(width/2, true);
    particle = new Particle(self);
    particle.setColor(color(255, 20, 20)).setRadius(7.0);  //particleの色,大きさ設定
    clearParticle = new Particle(self);
    clearParticle.setColor(color(255, 255, 50, 50)).setRadius(80.0);  //clearParticleの色,大きさ設定
    bossParticle = new Particle(self);
    bossParticle.setColor(color(255, 255, 50, 50)).setRadius(40.0);  //bossParticleの色,大きさ設定
    particleRainbow = new ParticleRainbow(self);
    particleRainbow.setRadius(80.0);
    //ブロッククラスの配列初期化
    for (int i = 0; i < block.length; i++) {
      block[i] = new Block(0, 0, 0, 0, false);
    }
    bossBlock = new BossBlock(-100, -100, 0, 0, 10, false);
    //ステージ分岐
    switch(stage) {
    case 1:
      setStage1();
      break;
    case 2:
      setStage2();
      break;
    case 3 :
      setStage3();
      break;
    case 4 :
      setStage4();
      break;
    case 5 :
      setStage5();
      break;
    case 6 :
      setStage6();
      break;
    case 7:
      setStage7();
      break;
    case 8:
      scene = 3;
      sound.stop();
      sound.gameClear();
      manageGame.stop();
      break;
    }
  }

  void draw() {
    image(background, 0, 0);
    count++;
    if (player.getIsActive()) {
      player.draw();
      player.update();
    }
    fill(255);
    ui.level();
    ui.time();
    //bulletクラスArrayListの要素を削除
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).draw();
      if (!bullets.get(i).isActive()) {
        bullets.remove(i);
      }
    }
    for (int i = 0; i < blockBullets.size(); i++) {
      blockBullets.get(i).draw();
      if (!blockBullets.get(i).isActive()) {
        blockBullets.remove(i);
      }
    }
    for (int i = 0; i < bossBullets.size(); i++) {
      bossBullets.get(i).draw();
      if (!bossBullets.get(i).isActive()) {
        bossBullets.remove(i);
      }
    }
    switch(stage) {
    case 1:
      stage1();
      break;
    case 2:
      stage2();
      break;
    case 3 :
      stage3();
      break;
    case 4 :
      stage4();
      break;
    case 5:
      stage5();
      break;
    case 6:
      stage6();
      break;
    case 7:
      stage7();
      break;
    }
  }

  //bullet生成
  void createBullet() {
    bullets.add(new Bullet(player.getPos().x, player.getPos().y, -35, 0));
  }
  void createBlockBullet(int blockNum) {
    if (block[blockNum].isActive) {
      blockBullets.add(new Bullet(block[blockNum].getPos().x, block[blockNum].getPos().y, 15, 1));
    }
  }
  void createBossBullet() {
    if (bossBlock.isActive) {
      bossBullets.add(new Bullet(random(bossBlock.getPos().x, bossBlock.getPos().x+bossBlock.getW()-150), bossBlock.getPos().y + bossBlock.getH(), 15, 1));
    }
  }
  //bullet当たり判定
  void checkHit() {
    boolean isHit;
    //ブロック
    for (int i = 0; i < bullets.size(); i++) {
      for (int j = 0; j < block.length; j++) {
        isHit = HitService.isHit(1, block[j].getPos(), player.getPos(), bullets.get(i).getPos(),
          block[j].getW(), block[j].getH(), player.getW(), bullets.get(i).getW(), bullets.get(i).getH());
        if (isHit == true && block[j].isActive == true) {
          sound.burst();
          //ヒットエフェクト生成
          particle.drawing(block[j].getPos().x + (block[j].getW()/2), block[j].getPos().y + (block[j].getH()/2));
          bullets.remove(i);
          block[j].isActive = false;
          break;
        }
      }
    }
    //ボスブロック
    for (int i = 0; i < bullets.size(); i++) {
      isHit = HitService.isHit(1, bossBlock.getPos(), player.getPos(), bullets.get(i).getPos(),
        bossBlock.getW(), bossBlock.getH(), player.getW(), bullets.get(i).getW(), bullets.get(i).getH());
      if (isHit == true && bossBlock.isActive == true) {
        sound.burst();
        bullets.remove(i);
        bossBlock.damage();
        if (!bossBlock.isActive()) {
          //ヒットエフェクト生成
          bossParticle.drawing(bossBlock.getPos().x + (bossBlock.getW()/2), bossBlock.getPos().y + (bossBlock.getH()/2));
        }
        break;
      }
    }
    if (checkClear()) {
      setStage(stage + 1);
    }
    //プレイヤー(ゲームオーバー);
    for (int i = 0; i < blockBullets.size(); i++) {
      isHit = HitService.isHit(0, block[0].getPos(), player.getPos(), blockBullets.get(i).getPos(),
        block[0].getW(), block[0].getH(), player.getW(), blockBullets.get(i).getW(), blockBullets.get(i).getH());
      if (isHit == true) {
        blockBullets.remove(i);
        player.isActive = false;
        scene = 2;
        sound.stop();
        sound.burst();
        sound.gameOver();
        manageGame.stop();
      }
    }
    //ボスbulletのプレイヤー(ゲームオーバー);
    for (int i = 0; i < bossBullets.size(); i++) {
      isHit = HitService.isHit(0, bossBlock.getPos(), player.getPos(), bossBullets.get(i).getPos(),
        bossBlock.getW(), bossBlock.getH(), player.getW(), bossBullets.get(i).getW(), bossBullets.get(i).getH());
      println(isHit);
      if (isHit == true) {
        bossBullets.remove(i);
        player.isActive = false;
        scene = 2;
        sound.stop();
        sound.burst();
        sound.gameOver();
        manageGame.stop();
      }
    }
  }
  //ステージ毎のコード
  void setStage1() {
    block[0] = new Block(random(80, width - 130), random(100, 300), 0, 0, true);
  }
  void stage1() {
    checkHit();
    if (bossBlock.isActive) {
    }
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%120 == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage2() {
    block[0] = new Block(random(80, width/2 - 50), random(100, 300), 0, 0, true);
    block[1] = new Block(random(width/2 + 30, width - 130), random(100, 300), 0, 0, true);
  }
  void stage2() {
    checkHit();
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%120 == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage3() {
    block[0] = new Block(random(80, width/2 - 130), random(100, 300), 5, 0, true);
  }
  void stage3() {
    checkHit();
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%120 == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage4() {
    block[0] = new Block(random(80, width/2 - 50), random(100, 300), 5, 0, true);
    block[1] = new Block(random(width/2 + 50, width - 130), random(100, 300), -5, 0, true);
  }
  void stage4() {
    checkHit();
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%120 == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage5() {
    block[0] = new Block(random(80, width/3 - 50), random(150, 250), 5, 3, true);
    block[1] = new Block(random(width/3 + 50, width/3*2 - 50), random(150, 250), -7, -3, true);
    block[2] = new Block(random(width/3*2 + 50, width - 130), random(150, 250), -5, 3, true);
  }
  void stage5() {
    checkHit();
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%(120 + i*10) == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage6() {
    block[0] = new Block(random(80, width/3 - 50), random(150, 250), 5, 3, true);
    block[1] = new Block(random(width/3 + 50, width/3*2 - 50), random(150, 250), -7, -3, true);
    block[2] = new Block(random(width/3*2 + 50, width - 130), random(150, 250), -5, 3, true);
    block[3] = new Block(random(width/3*2 + 50, width - 130), random(150, 250), -8, -10, true);
  }
  void stage6() {
    checkHit();
    for (int i = 0; i < block.length; i++) {
      if (block[i].isActive) {
        block[i].draw();
        if (count%(80 + i*10) == 0) {//bullet発射頻度
          createBlockBullet(i);
        }
      }
    }
  }
  void setStage7() {
    bossBlock = new BossBlock(width/2 - (bossBlock.getW()/2), 20, 0, 0, 10, true);
  }
  void stage7() {
    checkHit();
    if (bossBlock.isActive) {
      bossBlock.draw();
      if (count%80 == 0) {//bullet発射頻度
        createBossBullet();
        println("creatBossBullet");
      }
    }
  }
  int getCount() {
    return count;
  }

  int getStage() {
    return stage;
  }
}
