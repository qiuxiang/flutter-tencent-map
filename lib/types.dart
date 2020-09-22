/// 经纬度坐标
class LatLng {
  /// 纬度
  final double latitude;

  /// 经度
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  LatLng.fromJson(json)
      : latitude = json[0],
        longitude = json[1];

  toJson() => [latitude, longitude];

  bool operator ==(it) =>
      it is LatLng && it.latitude == latitude && it.longitude == longitude;

  get hashCode => latitude.hashCode ^ longitude.hashCode;
}

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  Point.fromJson(json)
      : x = json[0],
        y = json[1];

  toJson() => [x, y];
}

/// 地图状态
class CameraPosition {
  /// 坐标
  final LatLng target;

  /// 地图俯仰角度 -45~0
  final double tilt;

  /// 地图旋转角度
  final double bearing;

  /// 地图缩放级别 4~21，室内图支持到 22
  final double zoom;

  CameraPosition({this.target, this.tilt, this.bearing, this.zoom});

  CameraPosition.fromJson(json)
      : target = LatLng.fromJson(json['target']),
        tilt = json['tilt'],
        bearing = json['bearing'],
        zoom = json['zoom'];

  toJson() => {
        'target': target?.toJson(),
        'tilt': tilt,
        'bearing': bearing,
        'zoom': zoom,
      };

  bool operator ==(_) =>
      _ is CameraPosition &&
      _.target == target &&
      _.tilt == tilt &&
      _.bearing == bearing &&
      _.zoom == zoom;

  get hashCode =>
      target.hashCode ^ tilt.hashCode ^ bearing.hashCode ^ zoom.hashCode;
}
