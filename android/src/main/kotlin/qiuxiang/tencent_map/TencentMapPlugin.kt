package qiuxiang.tencent_map

import androidx.annotation.NonNull
import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer
import io.flutter.embedding.engine.plugins.FlutterPlugin

class TencentMapPlugin : FlutterPlugin {
  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    binding.platformViewRegistry.registerViewFactory("tencent_map", TencentMapFactory(binding.binaryMessenger))
    TencentMapInitializer.setAgreePrivacy(true)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
