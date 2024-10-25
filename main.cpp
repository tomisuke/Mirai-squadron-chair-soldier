#include "M5StickCPlus2.h"
#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

void setup()
{
  auto cfg = M5.config();
  StickCP2.begin(cfg);
  Serial.begin(9600);
  SerialBT.begin("TomisukeM5");

  pinMode(19, OUTPUT);
}

void loop()
{
  M5.update();
  double gyroZ;
  double gyroY;
  auto imu_update = StickCP2.Imu.update();
  if (imu_update)
  {
    auto data = StickCP2.Imu.getImuData();
    gyroZ = data.gyro.z;
    gyroY = data.gyro.y;
  }
  //SerialBT.println(gyroY);
  if (gyroZ > 40)
  {
    digitalWrite(19, HIGH);
    SerialBT.println("1");
    while (true)
    {
      M5.update();
      auto imu_update = StickCP2.Imu.update();
      if (imu_update)
      {
        auto data = StickCP2.Imu.getImuData();
        gyroZ = data.gyro.z;
      }
      if (-25 >  gyroZ)
      {
        digitalWrite(19, LOW);
        break;
      }
    }
  }
}