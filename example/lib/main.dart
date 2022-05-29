import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: TencentMap()),
      ),
    );
  }
}
