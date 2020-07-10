import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TencentMapView extends StatefulWidget {
  const TencentMapView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TencentMapViewState();
}

class _TencentMapViewState extends State<TencentMapView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'TencentMapView',
      );
    }
    return Text('$defaultTargetPlatform is not yet supported');
  }
}
