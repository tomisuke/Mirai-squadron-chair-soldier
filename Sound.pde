class Sound {
  Sound() {
  }
  void title() {
    minim = new Minim(self);
    BGM = minim.loadFile("title.mp3");
    //BGM.setVolume(30);
    BGM.play();
  }
  void game() {
    minim = new Minim(self);
    BGM = minim.loadFile("game.mp3");
    BGM.play();
  }
  void enter() {
    minim = new Minim(self);
    SoundEffect = minim.loadFile("enter.mp3");
    SoundEffect.play();
  }
  void bullet() {
    minim = new Minim(self);
    SoundEffect = minim.loadFile("bullet.mp3");
    SoundEffect.play();
  }
  void hit() {
    minim = new Minim(self);
    SoundEffect = minim.loadFile("hit.mp3");
    SoundEffect.play();
  }
  void gameOver() {
    minim = new Minim(self);
    BGM = minim.loadFile("gameOver.mp3");
    BGM.play(); 
  }
  void burst() {
    minim = new Minim(self);
    SoundEffect = minim.loadFile("burst.mp3");
    SoundEffect.play();
  }
  void gameClear() {
    minim = new Minim(self);
    SoundEffect = minim.loadFile("clear.mp3");
    SoundEffect.play();
  }
  void gameClear2() {
    minim = new Minim(self);
    BGM = minim.loadFile("clear2.mp3");
    BGM.play();
  }
  void stop() {
    BGM.close();
    minim.stop();
    //self.super.stop();
  }
}
