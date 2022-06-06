import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    javaOut: 'android/src/main/java/qiuxiang/tencent_map/Pigeon.java',
    javaOptions: JavaOptions(package: 'qiuxiang.tencent_map'),
  ),
)
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
  void moveCamera(Map position, int duration);
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
  void onCameraMoveStarted(CameraPosition cameraPosition);
  void onCameraMove(CameraPosition cameraPosition);
  void onCameraIdle(CameraPosition cameraPosition);
}

enum MapType {
  normal,
  satellite,
  dark,
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}

class MapPoi {
  final String name;
  final LatLng position;

  const MapPoi(this.name, this.position);
}

class CameraPosition {
  double? bearing;
  LatLng? target;
  double? tilt;
  double? zoom;

  CameraPosition({
    this.bearing,
    this.target,
    this.tilt,
    this.zoom,
  });
}
