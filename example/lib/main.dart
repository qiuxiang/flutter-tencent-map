import 'dart:math';
import 'package:flutter/material.dart';

import 'package:tencent_map/tencent_map.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  final key = UniqueKey();
  createState() => _AppState();
}

class _AppState extends State {
  build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: MapView(),
      ),
    );
  }
}

class MapView extends StatelessWidget {
  final _key = UniqueKey();
  TencentMapController _controller;
  Offset _point;
  CameraPosition _cameraPosition;

  build(context) {
    final ratio = MediaQuery.of(context).devicePixelRatio;
    return GestureDetector(
      onScaleStart: (data) async {
        _point = data.focalPoint;
        _cameraPosition = await _controller.getCameraPosition();
        _controller.setCameraPosition(
          CameraPosition(zoom: _cameraPosition.zoom),
        );
      },
      onScaleUpdate: (data) {
        _controller.setCameraPosition(
          CameraPosition(
            zoom: _cameraPosition.zoom + log(data.scale) / log(2),
            bearing: _cameraPosition.bearing + data.rotation / pi * 180,
          ),
          Point(
            (data.focalPoint.dx - _point.dx) * ratio,
            (data.focalPoint.dy - _point.dy) * ratio,
          ),
        );
        _point = data.focalPoint;
      },
      onScaleEnd: (data) {
        print(data.velocity);
      },
      child: TencentMap(
        key: _key,
        onCreated: (controller) => _controller = controller,
      ),
    );
  }
}
