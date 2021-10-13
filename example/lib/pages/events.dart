import 'package:tencent_map/tencent_map.dart';
import 'package:flutter/material.dart';

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
        onCameraMoveStarted: logger('onCameraMoveStarted'),
        onCameraMove: logger('onCameraMove'),
        onCameraIdle: logger('onCameraIdle'),
      ),
    );
  }

  logger(String name) {
    return (Object data) => print('$name: $data');
  }
}
