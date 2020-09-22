package qiuxiang.flutter.tencent_map

import android.content.Context
import android.view.View
import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import com.tencent.tencentmap.mapsdk.maps.TencentMap as Map


class TencentMap(context: Context, messenger: BinaryMessenger, id: Int, args: HashMap<*, *>) : PlatformView, MethodCallHandler {
  private var mapView: MapView = TextureMapView(context)
  private var map: Map
  private val channel = MethodChannel(messenger, "TencentMap_$id")

  init {
    map = mapView.map
    channel.setMethodCallHandler(this)
  }

  override fun getView(): View {
    return mapView
  }

  override fun dispose() {
    mapView.onDestroy()
  }

  private fun setCameraPosition(status: HashMap<*, *>) {
    val position = CameraPosition.builder().apply {
      target((status["target"] as? ArrayList<*>)?.toLatLng())
      (status["tilt"] as? Double)?.toFloat()?.let { tilt(it) }
      (status["bearing"] as? Double)?.toFloat()?.let { bearing(it) }
      (status["zoom"] as? Double)?.toFloat()?.let { zoom(it) }
    }.build()

    map.moveCamera(CameraUpdateFactory.newCameraPosition(position))
  }

  private fun scrollBy(arguments: ArrayList<*>) {
    map.moveCamera(CameraUpdateFactory.scrollBy(
      (arguments[0] as Double).toFloat(), (arguments[1] as Double).toFloat()))
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "setCameraPosition" -> {
        val arguments = call.arguments as ArrayList<*>
        setCameraPosition(arguments[0] as HashMap<*, *>)
        (arguments[1] as? ArrayList<*>)?.let { scrollBy(it) }
        result.success(null)
      }
      "getCameraPosition" -> {
        val a = map.cameraPosition.toJson()
        result.success(a)
      }
    }
  }
}