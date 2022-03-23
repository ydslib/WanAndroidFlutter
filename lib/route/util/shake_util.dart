import 'dart:async';

import 'package:flutter_sensors/flutter_sensors.dart';

class ShakeUtil {
  static final ShakeUtil _instance = ShakeUtil._init();

  OnShakeListener? _onShakeListener;

  /// 是否已经展示过
  bool isShow = false;

  ///是否已经启动
  bool _isStart = false;
  bool _gyroAvailable = false;

  StreamSubscription? _accelSubscription;

  ShakeUtil._init() {
    isShow = false;
    print("-------_init----------");
  }

  factory ShakeUtil() {
    return _instance;
  }

  static ShakeUtil getInstance() {
    return _instance;
  }

  void setOnShakeListener(OnShakeListener? onShakeListener) {
    _onShakeListener = onShakeListener;
  }

  Future<bool> checkAccelerometerStatus() =>
      SensorManager().isSensorAvailable(Sensors.ACCELEROMETER);

  Future<void> startAccelerometer({bool accelAvailable = false}) async {
    //只启动一次，防止重复启动
    if (_accelSubscription != null) return;

    if (accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );

      int lastTime = -1;

      _accelSubscription = stream.listen((sensorEvent) {
        _isStart = true;
        int value = 20;
        double x = sensorEvent.data[0];
        double y = sensorEvent.data[1];
        double z = sensorEvent.data[2];
        print("------$x------$y--------$z");

        if (x >= value ||
            x < -value ||
            y >= value ||
            y <= -value ||
            z >= value ||
            z <= -value) {
          int currentTime = DateTime.now().millisecondsSinceEpoch;
          if (currentTime - lastTime >= 1500) {
            lastTime = currentTime;
            _onShakeListener?.call();
          }
        }
      });
    }
  }

  void stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription?.cancel();
    _accelSubscription = null;
    _isStart = false;
  }

  void checkGyroscopeStatus() async {
    await SensorManager().isSensorAvailable(Sensors.GYROSCOPE).then((result) {
      _gyroAvailable = result;
    });
  }

  void dispose() {
    stopAccelerometer();
  }
}

typedef OnShakeListener = void Function();
