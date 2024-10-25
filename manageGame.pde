class ManageGame {
  private long startTime, time;
  private boolean flag;
  ManageGame() {
  }
  void start() {
    startTime = millis();
    flag = true;
  }
  void stop() {
    flag = false;
  }
  String getTime() {
    if (flag) {
      time = millis();
    }
    long elapsedTime = (time - startTime);
    long min = (elapsedTime/60)/1000;
    long second = (elapsedTime - (min*60*1000))/1000;
    long period = (elapsedTime - (min*60*1000) - (second*1000));
    return (nf(min, 2, 0) + ":" + nf(second, 2, 0) + "." + nf(period, 3, 0));
  }
}
