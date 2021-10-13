package qiuxiang.flutter.tencent_map

import io.flutter.embedding.engine.plugins.FlutterPlugin

class TencentMapPlugin : FlutterPlugin {
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    binding.platformViewRegistry.registerViewFactory(
      "TencentMap", TencentMapFactory(binding.binaryMessenger)
    )
  }
}
