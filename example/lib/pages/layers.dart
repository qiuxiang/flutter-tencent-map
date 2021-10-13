import 'package:tencent_map/tencent_map.dart';
import 'package:flutter/material.dart';

class LayersPage extends StatefulWidget {
  const LayersPage({Key? key}) : super(key: key);

  @override
  createState() => _State();
}

const traffic = '路况';
const indoor = '室内图';
const buildings = '3D 建筑';

class _State extends State<LayersPage> {
  final _state = {traffic: true};
  final _items = [traffic, indoor, buildings];

  @override
  build(context) {
    final items = _items.map(
      (it) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.only(top: 16), child: Text(it)),
          Switch(
            value: _state[it] ?? false,
            onChanged: (value) => setState(() => _state[it] = value),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('图层：路况、室内图、3D 建筑')),
      body: TencentMap(
        trafficEnabled: _state[traffic] ?? false,
        indoorViewEnabled: _state[indoor] ?? false,
        buildingsEnabled: _state[buildings] ?? false,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.toList(),
      ),
    );
  }
}
