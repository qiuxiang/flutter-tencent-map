flutter 腾讯地图组件，探索 PlatformView 开发的最佳实践，开发中。

接口基本遵循 `google_map`，理论上可以使用 `google_maps_flutter_platform_interface`
定义好的接口进行开发，不过还是决定尝试 all in `pigeon`。

从 flutter v3 开始，AndroidView 的默认实现从 VirtualDisplay 改为 TextureLayer，
解决了部分性能问题，但与 SurfaceView 不兼容，而 TextureMapView 的性能是不能接受的。
目前我能找到最好的方案是 hybrid composition。值得注意的是，目前 flutter 官方文档
[Android platform-views](https://docs.flutter.dev/development/platform-integration/android/platform-views)
是过时的，且不说 VirtualDisplay 已被移除，里面展示的代码已经不能实现 hybrid composition。
因为 `PlatformViewsService.initSurfaceAndroidView` 已被改成用于实现 TextureLayer，正确的用法是
`PlatformViewsService.initExpensiveAndroidView`。从接口的变动可以看出官方的态度，hybrid composition
随时可能被遗弃，不过这不是问题，目前的实现的接口完全兼容 AndroidView（希望 flutter 官方不要做出在
SurfaceView 问题还没解决之前就移除 hybrid composition 的愚蠢决定）。

## Build

```
flutter pub run pigeon --input lib/src/pigeon.dart
```
