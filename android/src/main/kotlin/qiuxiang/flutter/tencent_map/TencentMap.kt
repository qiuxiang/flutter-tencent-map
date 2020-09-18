package qiuxiang.flutter.tencent_map

import android.view.View
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMapOptions
import com.tencent.tencentmap.mapsdk.maps.model.MapViewType
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import qiuxiang.flutter.tencent_map.TencentMapPlugin.Companion.activity


class TencentMap(var messenger: BinaryMessenger, id: Int, args: HashMap<*, *>) : PlatformView, MethodCallHandler {
  private var mapView: MapView

  init {
    val options = TencentMapOptions()
    options.mapViewType = MapViewType.SurfaceView
    mapView = MapView(activity, options);
    mapView.onResume()
  }

  override fun getView(): View {
    return mapView
  }

  override fun dispose() {
    mapView.onDestroy()
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    TODO("Not yet implemented")
  }
}