static class HitService {
  static boolean isHit(int type, PVector blockPos, PVector playerPos, PVector bulletPos, float blockW, float blockH, float playerW, float bulletW, float bulletH) {
    PVector blockPosBottomL, blockPosBottomR, playerPosTopL, playerPosTopR, bulletPosTopL, playerPosBottomL, playerPosBottomR, bulletPosTopR, bulletPosBottomL, bulletPosBottomR;
    blockPosBottomL = new PVector(blockPos.x, blockPos.y + blockH);
    blockPosBottomR = new PVector(blockPos.x + blockW, blockPos.y + blockH);
    playerPosTopL = new PVector(playerPos.x, playerPos.y);
    playerPosTopR = new PVector(playerPos.x + playerW, playerPos.y);
    playerPosBottomL = new PVector(playerPos.x, playerPos.y + playerW);//正方形である前提
    playerPosBottomR = new PVector(playerPos.x + playerW, playerPos.y + playerW);
    bulletPosTopL = new PVector(bulletPos.x, bulletPos.y);
    bulletPosTopR = new PVector(bulletPos.x + bulletW, bulletPos.y);
    bulletPosBottomL = new PVector(bulletPos.x, bulletPos.y + bulletH);
    bulletPosBottomR = new PVector(bulletPos.x + bulletW, bulletPos.y + bulletH);

    //敵当たり判定
    if (type == 1) {
      if (bulletPosTopL.y < blockPosBottomL.y && (blockPosBottomL.x < bulletPosTopR.x && bulletPosTopL.x < blockPosBottomR.x)) {
        println("true");
        return true;
      } else {
        return false;
      }
    } else {
      if ((bulletPosBottomL.y > playerPosTopL.y && playerPosBottomL.y > bulletPosTopL.y)&&
        (playerPosTopL.x < bulletPosBottomR.x && bulletPosBottomL.x < playerPosTopR.x)) {
        println("true");
        return true;
      } else {
        return false;
      }
    }
  }
}
