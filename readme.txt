このプログラムは､M5StickC Plus2が接続されている場合に動作します｡

M5StickC Plus2が接続されていない場合は､block1024016.pdeの32行目､
port = new Serial(this, "COM8", 9600);
及びblock1024016.pdeの63行目､
port.stop();
を無効にしてください｡M5StickC Plus2から送信されるコマンドは､Shiftキーを押すことで実行されます｡ゲーム上に表示されるRecliningをShiftに読み替えてください｡また､移動はマウスで行ってください｡