import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

/// 地图类型
class MapType {
  /// 普通地图
  static const normal = 1;

  /// 卫星图
  static const satellite = 2;

  /// 空白地图
  static const none = 3;
}

/// 地图兴趣点
class MapPoi {
  const MapPoi({required this.name, required this.position});

  /// 兴趣点名称
  final String name;

  /// 兴趣点坐标
  final LatLng position;

  static MapPoi fromJson(Map json) {
    return MapPoi(
      name: json['name'],
      position: LatLng.fromJson(json['position'])!,
    );
  }

  Object toJson() => {'position': position.toJson(), 'name': name};

  @override
  String toString() => '${toJson()}';
}
