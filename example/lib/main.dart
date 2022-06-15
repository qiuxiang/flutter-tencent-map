import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import 'pages/add_remove_marker.dart';
import 'pages/controls.dart';
import 'pages/events.dart';
import 'pages/layers.dart';
import 'pages/map_types.dart';
import 'pages/move_camera.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    TencentMap.init();
  }

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
          Item('动态添加、移除标记', (_) => const AddRemoveMarkerPage()),
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
