import 'package:tencent_map/tencent_map.dart';
import 'package:flutter/material.dart';

class MapTypeItem {
  final String name;
  final int value;

  MapTypeItem(this.name, this.value);
}

class MapTypesPage extends StatefulWidget {
  const MapTypesPage({Key? key}) : super(key: key);

  @override
  State<MapTypesPage> createState() => _MapTypesPageState();
}

class _MapTypesPageState extends State<MapTypesPage> {
  int mapType = MapType.satellite;
  final types = {
    MapType.normal: '常规',
    MapType.satellite: '卫星',
    MapType.none: '空白',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地图类型切换'),
        actions: [
          DropdownButton<int>(
            value: mapType,
            items: types.keys
                .map((i) => DropdownMenuItem(value: i, child: Text(types[i]!)))
                .toList(),
            onChanged: (value) => setState(() => mapType = value!),
          )
        ],
      ),
      body: TencentMap(mapType: mapType),
    );
  }
}
