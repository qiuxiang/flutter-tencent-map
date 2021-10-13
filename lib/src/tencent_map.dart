import 'package:tencent_map/src/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    hide MapType;

import 'pigeon.g.dart';

/// 百度地图组件
class TencentMap extends StatefulWidget {
  const TencentMap({
    Key? key,
    this.onMapCreated,
    this.compassEnabled = true,
    this.zoomControlsEnabled = true,
    this.scaleControlsEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.trafficEnabled = false,
    this.indoorViewEnabled = false,
    this.buildingsEnabled = true,
    this.mapType = MapType.normal,
    this.onTap,
    this.onTapPoi,
    this.onLongPress,
    this.onCameraMoveStarted,
    this.onCameraMove,
    this.onCameraIdle,
  }) : super(key: key);

  /// 地图类型 [MapType]
  final int mapType;

  /// 指南针是否显示
  final bool compassEnabled;

  /// 是否显示缩放控件
  final bool zoomControlsEnabled;

  /// 是否显示比例尺控件
  final bool scaleControlsEnabled;

  /// 指南针是否显示
  final bool rotateGesturesEnabled;

  /// 是否允许拖拽手势
  final bool scrollGesturesEnabled;

  /// 是否允许俯视手势
  final bool tiltGesturesEnabled;

  /// 是否打开交通图层
  final bool trafficEnabled;

  /// 是否显示室内图
  ///
  /// 室内图只有在缩放级别 [17， 22] 范围才生效，但是在18级之上（包含18级）才会有楼层边条显示。
  final bool indoorViewEnabled;

  /// 是否允许楼块效果
  final bool buildingsEnabled;

  /// 地图创建完成时调用
  ///
  /// 可以使用参数 [TencentMapController] 控制地图
  final void Function(TencentMapController)? onMapCreated;

  /// 地图空白区域单击事件回调函数
  final void Function(LatLng)? onTap;

  /// 地图兴趣点单击事件回调函数
  final void Function(MapPoi)? onTapPoi;

  /// 地图长按事件回调函数
  final void Function(LatLng)? onLongPress;

  /// 地图状态开始改变时调用
  final void Function(CameraPosition)? onCameraMoveStarted;

  /// 地图状态改变时调用
  final void Function(CameraPosition)? onCameraMove;

  /// 地图状态结束改变时调用
  final void Function(CameraPosition)? onCameraIdle;

  @override
  createState() => _TencentMapState();
}

class _TencentMapState extends State<TencentMap> {
  final _api = TencentMapApi();
  late TencentMapController _controller;

  @override
  build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'TencentMap',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'TencentMap',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not yet supported');
    }
  }

  @override
  didUpdateWidget(old) {
    super.didUpdateWidget(old);
    if (widget.mapType != old.mapType) {
      _api.setMapType(widget.mapType);
    }
    if (widget.compassEnabled != old.compassEnabled) {
      _api.setCompassEnabled(widget.compassEnabled);
    }
    if (widget.zoomControlsEnabled != old.zoomControlsEnabled) {
      _api.setZoomControlsEnabled(widget.zoomControlsEnabled);
    }
    if (widget.scaleControlsEnabled != old.scaleControlsEnabled) {
      _api.setScaleControlsEnabled(widget.scaleControlsEnabled);
    }
    if (widget.tiltGesturesEnabled != old.tiltGesturesEnabled) {
      _api.setTiltGesturesEnabled(widget.tiltGesturesEnabled);
    }
    if (widget.scrollGesturesEnabled != old.scrollGesturesEnabled) {
      _api.setScrollGesturesEnabled(widget.scrollGesturesEnabled);
    }
    if (widget.rotateGesturesEnabled != old.rotateGesturesEnabled) {
      _api.setRotateGesturesEnabled(widget.rotateGesturesEnabled);
    }
    if (widget.trafficEnabled != old.trafficEnabled) {
      _api.setTrafficEnabled(widget.trafficEnabled);
    }
    if (widget.indoorViewEnabled != old.indoorViewEnabled) {
      _api.setIndoorViewEnabled(widget.indoorViewEnabled);
    }
    if (widget.buildingsEnabled != old.buildingsEnabled) {
      _api.setBuildingsEnabled(widget.buildingsEnabled);
    }
  }

  _onPlatformViewCreated(int id) {
    TencentMapListener.setup(_TencentMapListener(widget));
    _controller = TencentMapController(id, _api);
    widget.onMapCreated?.call(_controller);
    didUpdateWidget(const TencentMap());
  }
}

class _TencentMapListener extends TencentMapListener {
  TencentMap widget;

  _TencentMapListener(this.widget);

  @override
  void onTap(List<Object?> latLng) {
    widget.onTap?.call(LatLng.fromJson(latLng)!);
  }

  @override
  void onTapPoi(Map<Object?, Object?> poi) {
    widget.onTapPoi?.call(MapPoi.fromJson(poi));
  }

  @override
  void onLongPress(List<Object?> latLng) {
    widget.onLongPress?.call(LatLng.fromJson(latLng)!);
  }

  @override
  void onCameraIdle(Map<Object?, Object?> cameraPosition) {
    widget.onCameraIdle?.call(CameraPosition.fromMap(cameraPosition)!);
  }

  @override
  void onCameraMove(Map<Object?, Object?> cameraPosition) {
    widget.onCameraMove?.call(CameraPosition.fromMap(cameraPosition)!);
  }

  @override
  void onCameraMoveStarted(Map<Object?, Object?> cameraPosition) {
    widget.onCameraMoveStarted?.call(CameraPosition.fromMap(cameraPosition)!);
  }
}

/// 地图控制器，提供地图控制接口
class TencentMapController {
  TencentMapController(int id, this._api);

  final TencentMapApi _api;

  void moveCamera(CameraPosition position, [Duration? duration]) {
    _api.moveCamera(position.toMap() as Map, duration?.inMilliseconds ?? 0);
  }
}
