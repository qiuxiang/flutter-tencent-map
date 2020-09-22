import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'types.dart';

export 'types.dart';

class TencentMap extends StatefulWidget {
  final void Function(TencentMapController) onCreated;

  const TencentMap({Key key, this.onCreated}) : super(key: key);

  createState() => _TencentMapState();

  toJson() => {};
}

class _TencentMapState extends State<TencentMap> {
  TencentMapController _controller;

  _onPlatformViewCreated(int id) {
    _controller = TencentMapController(id, this);
    if (widget.onCreated != null) {
      widget.onCreated(_controller);
    }
  }

  build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'TencentMap',
          creationParams: widget.toJson(),
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'TencentMap',
          creationParams: widget.toJson(),
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not yet supported');
    }
  }
}

class TencentMapController {
  final MethodChannel _channel;
  final _TencentMapState _state;

  TencentMapController(int id, this._state)
      : _channel = MethodChannel('TencentMap_$id') {
    // _channel.setMethodCallHandler((call) {});
  }

  /// 设置地图状态，支持动画过度
  Future<void> setCameraPosition(CameraPosition position, [Point point]) {
    return _channel.invokeMethod(
        'setCameraPosition', [position.toJson(), point?.toJson()]);
  }

  Future<CameraPosition> getCameraPosition() async {
    return CameraPosition.fromJson(
        await _channel.invokeMethod('getCameraPosition'));
  }
}
