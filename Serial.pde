import processing.serial.*;
Serial port;
void setEvent(int eventNum) {
  switch(eventNum) {
  case 0:
    enterGame();
    break;
  case 1:
    gameScene.createBullet();
    sound.bullet();
    break;
  case 2:
    sound.stop();
    scene = 0;
    sound.title();
    break;
  case 3:
    sound.stop();
    scene = 0;
    sound.title();
    break;
  case 4:
    if (gameScene.getStage() != 6) {
      setStage(6);
    } else {
      setStage(7);
    }
    break;
  }
  setEventNum = -1;
}
void serialEvent(Serial port)
{
  // シリアルポートからデータを受け取ったら
  if (port.available() >= 1) {
    String data = port.readStringUntil('\n');
    if (data == null) {
      return;
    }
    data = data.trim();
    println(data);  
    if (int(data) == 1) {
      if (scene == 0) {//title
        println("serialスタート");
        setEventNum = 0;
      } else if (scene == 1) {//gameScene
        setEventNum = 1;
      } else if (scene == 2) {//gameOver
        setEventNum = 2;
      } else if (scene == 3) {//gameClear
        setEventNum = 3;
      }
    } else if (int(data) == 2) {
      setEventNum = 4;
    }
  }
}
