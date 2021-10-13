import 'package:tencent_map/tencent_map.dart';
import 'package:flutter/material.dart';

import 'pages/controls.dart';
import 'pages/events.dart';
import 'pages/layers.dart';
import 'pages/map_types.dart';
import 'pages/move_camera.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(children: [
          Item('地图类型切换', (_) => const MapTypesPage()),
          Item('地图视角移动', (_) => const MoveCameraPage()),
          Item('图层：路况、室内图、3D 建筑', (_) => const LayersPage()),
          Item('控件：比例尺、缩放按钮、指南针', (_) => const ControlsPage()),
          Item('地图事件回调', (_) => const EventsPage()),
        ]),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext) builder;

  const Item(this.title, this.builder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: builder)),
    );
  }
}
