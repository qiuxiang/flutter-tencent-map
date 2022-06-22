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
  void setMyLocationButtonEnabled(bool enabled);
  void setMyLocationEnabled(bool enabled);
  void setMyLocation(Location location);
  void moveCamera(CameraPosition position, int duration);
  String addMarker(MarkerOptions options);
  void pause();
  void resume();
  void destory();
}

@FlutterApi()
abstract class TencentMapHandler {
  void onTap(LatLng latLng);
  void onTapPoi(MapPoi poi);
  void onLongPress(LatLng latLng);
  void onCameraMove(CameraPosition cameraPosition);
  void onCameraIdle(CameraPosition cameraPosition);
  void onTapMarker(String markerId);
  void onMarkerDragStart(String markerId, LatLng latLng);
  void onMarkerDrag(String markerId, LatLng latLng);
  void onMarkerDragEnd(String markerId, LatLng latLng);
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

class Location {
  double? latitude;
  double? longitude;
  double? bearing;
  double? accuracy;
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
  double? alpha;
  double? rotation;
  int? zIndex;
  bool? flat;
  bool? draggable;
  Bitmap? icon;
  List<double?>? anchor;
}

class Bitmap {
  String? asset;
  Uint8List? bytes;
}

@HostApi()
abstract class MarkerApi {
  void remove(String id);
  void setRotation(String id, double rotation);
  void setPosition(String id, LatLng position);
  void setAnchor(String id, double x, double y);
  void setZIndex(String id, int zIndex);
  void setAlpha(String id, double alpha);
  void setIcon(String id, Bitmap icon);
  void setDraggable(String id, bool draggable);
}
