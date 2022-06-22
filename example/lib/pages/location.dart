import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import '../utils.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('定位')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        myLocationStyle: MyLocationStyle(
          myLocationType: MyLocationType.followNoCenter,
        ),
        onMapCreated: (controller) async {
          controller.moveCamera(
            CameraPosition(
              target: LatLng(latitude: 39.909, longitude: 116.397),
            ),
          );
          controller.setMyLocation(
            Location(latitude: 39.909, longitude: 116.397, accuracy: 1000),
          );
        },
      ),
    );
  }
}
