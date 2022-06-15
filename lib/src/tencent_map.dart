import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'marker.dart';
import 'pigeon.g.dart';

final _sdkApi = TencentMapSdkApi();

/// 腾讯地图
class TencentMap extends StatefulWidget {
  const TencentMap({
    Key? key,
    this.onMapCreated,
    this.compassEnabled = false,
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
    this.onCameraMove,
    this.onCameraIdle,
    this.onTapMarker,
  }) : super(key: key);

  /// 地图类型
  final MapType mapType;

  /// 指南针是否显示
  final bool compassEnabled;

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

  /// 地图状态改变时调用
  final void Function(CameraPosition)? onCameraMove;

  /// 地图状态结束改变时调用
  final void Function(CameraPosition)? onCameraIdle;

  /// 点击地图标记时调用
  final void Function(String markerId)? onTapMarker;

  @override
  createState() => _TencentMapState();

  static init([String iosApiKey = '']) {
    _sdkApi.initSdk(iosApiKey);
  }
}

class _TencentMapState extends State<TencentMap> with WidgetsBindingObserver {
  final _api = TencentMapApi();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _api.resume();
        break;
      case AppLifecycleState.paused:
        _api.pause();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'tencent_map',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'tencent_map',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not supported');
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
    TencentMapHandler.setup(_TencentMapHandler(widget));
    widget.onMapCreated?.call(TencentMapController(_api));
    didUpdateWidget(const TencentMap());
  }
}

class _TencentMapHandler extends TencentMapHandler {
  TencentMap widget;

  _TencentMapHandler(this.widget);

  @override
  void onCameraIdle(CameraPosition cameraPosition) {
    widget.onCameraIdle?.call(cameraPosition);
  }

  @override
  void onCameraMove(CameraPosition cameraPosition) {
    widget.onCameraMove?.call(cameraPosition);
  }

  @override
  void onLongPress(LatLng latLng) {
    widget.onLongPress?.call(latLng);
  }

  @override
  void onTap(LatLng latLng) {
    widget.onTap?.call(latLng);
  }

  @override
  void onTapPoi(MapPoi mapPoi) {
    widget.onTapPoi?.call(mapPoi);
  }

  @override
  void onTapMarker(String markerId) {
    widget.onTapMarker?.call(markerId);
  }
}

/// 地图控制器，提供地图控制接口
class TencentMapController {
  TencentMapController(this._api);

  final TencentMapApi _api;

  void moveCamera(CameraPosition position, [Duration? duration]) {
    _api.moveCamera(position, duration?.inMilliseconds ?? 0);
  }

  Future<Marker> addMarket(MarkerOptions options) async {
    return Marker(await _api.addMarker(options));
  }
}
