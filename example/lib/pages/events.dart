import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('地图事件')),
      body: TencentMap(
        onTap: logger('onTap'),
        onTapPoi: logger('onTapPoi'),
        onLongPress: logger('onLongPress'),
        onCameraIdle: logger('onCameraIdle'),
      ),
    );
  }

  logger(String name) {
    // ignore: avoid_print
    return (dynamic data) => print('$name: ${data.encode()}');
  }
}
