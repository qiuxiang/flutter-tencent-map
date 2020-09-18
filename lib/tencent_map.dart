import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TencentMap extends StatefulWidget {
  const TencentMap();

  createState() => _TencentMapState();

  toJson() => {};
}

class _TencentMapState extends State<TencentMap> {
  _onPlatformViewCreated(int id) {
    // _controller = BaiduMapViewController(id, this);
    // if (widget.onCreated != null) {
    //   widget.onCreated(_controller);
    // }
  }

  build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'BaiduMapView',
          creationParams: widget.toJson(),
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'BaiduMapView',
          creationParams: widget.toJson(),
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not yet supported');
    }
  }
}
