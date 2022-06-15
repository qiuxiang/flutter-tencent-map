// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    javaOut: 'android/src/main/java/qiuxiang/tencent_map/Pigeon.java',
    javaOptions: JavaOptions(package: 'qiuxiang.tencent_map'),
    objcHeaderOut: 'ios/Classes/Pigeon.h',
    objcSourceOut: 'ios/Classes/Pigeon.m',
  ),
)
@HostApi()
abstract class TencentMapSdkApi {
  void initSdk(String iosApiKey);
}

@HostApi()
abstract class TencentMapApi {
  void setMapType(MapType type);
  void setCompassEnabled(bool enabled);
  void setScaleControlsEnabled(bool enabled);
  void setRotateGesturesEnabled(bool enabled);
  void setScrollGesturesEnabled(bool enabled);
  void setZoomGesturesEnabled(bool enabled);
  void setTiltGesturesEnabled(bool enabled);
  void setIndoorViewEnabled(bool enabled);
  void setTrafficEnabled(bool enabled);
  void setBuildingsEnabled(bool enabled);
  void moveCamera(CameraPosition position, int duration);
  String addMarker(MarkerOptions options);
  void pause();
  void resume();
  void start();
  void stop();
}

@FlutterApi()
abstract class TencentMapHandler {
  void onTap(LatLng latLng);
  void onTapPoi(MapPoi poi);
  void onLongPress(LatLng latLng);
  void onCameraMove(CameraPosition cameraPosition);
  void onCameraIdle(CameraPosition cameraPosition);
  void onTapMarker(String markerId);
}

enum MapType {
  normal,
  satellite,
  dark,
}

class LatLng {
  late double latitude;
  late double longitude;
}

class MapPoi {
  late String name;
  late LatLng position;
}

class CameraPosition {
  double? bearing;
  LatLng? target;
  double? tilt;
  double? zoom;
}

class MarkerOptions {
  late LatLng position;
}

@HostApi()
abstract class MarkerApi {
  void remove(String id);
}
