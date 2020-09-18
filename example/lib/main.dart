import 'package:flutter/material.dart';

import 'package:tencent_map/tencent_map.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  createState() => _AppState();
}

class _AppState extends State<App> {
  build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: const TencentMap(),
      ),
    );
  }
}
