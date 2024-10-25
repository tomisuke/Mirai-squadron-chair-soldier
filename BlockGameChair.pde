 //サウンド関係
Minim minim;
AudioPlayer BGM;
AudioPlayer SoundEffect;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.core.PApplet;
//フォント関係
PFont font;
//クラス宣言
GameScene gameScene;
GameOver gameOver;
ManageGame manageGame;
Title title;
GameClear gameClear;
Sound sound;
UI ui;
private int scene = 0;
PApplet self;
void setup() {
  noCursor();
  font = loadFont("Gkktt48.vlw");
  textFont(font);
  size(1920, 1200);
  background(0);
  self = this;
  //シーン初期化;
  port = new Serial(this, "COM13", 9600);//M5StickC Plus2がない場合､この行を無効化
  sound = new Sound();
  gameScene = new GameScene(1);
  ui = new UI();
  manageGame =new ManageGame();
  title = new Title();
  gameOver = new GameOver();
  gameClear = new GameClear();
  sound.title();
}
void draw() {
  setEvent(setEventNum);
  switch(scene) {
  case 0:
    title.draw();
    break;
  case 1:
    gameScene.draw();
    loopGameSound();
    ui.time();
    break;
  case 2:
    gameOver.draw();
    break;
  case 3:
    gameClear.draw();
    break;
  }
}

void dispose() {
  port.stop();  //M5StickC Plus2がない場合､この行を無効化
}
