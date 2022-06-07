import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initTencentMapSdk(iosApiKey: '');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('腾讯地图')),
        body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox();
            }
            return TencentMap(
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              onMapCreated: (container) {},
            );
          },
        ),
      ),
    );
  }
}
