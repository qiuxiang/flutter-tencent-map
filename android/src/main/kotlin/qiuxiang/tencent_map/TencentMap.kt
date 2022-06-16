package qiuxiang.tencent_map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(val binding: FlutterPlugin.FlutterPluginBinding, context: Context?) : PlatformView {
  private val mapHandler = Pigeon.TencentMapHandler(binding.binaryMessenger)
  private val mapView = TextureMapView(context!!)
  val map: TencentMap = mapView.map
  val markers = mutableMapOf<String, Marker>()

  override fun getView(): MapView {
    return mapView
  }

  override fun dispose() {}

  init {
    mapView.onResume()
    Pigeon.TencentMapApi.setup(binding.binaryMessenger, TencentMapApi(this))
    Pigeon.MarkerApi.setup(binding.binaryMessenger, MarkerApi(this))
    map.setOnMapClickListener { mapHandler.onTap(it.toLatLng()) {} }
    map.setOnMapPoiClickListener { mapHandler.onTapPoi(it.toMapPoi()) {} }
    map.setOnMapLongClickListener { mapHandler.onLongPress(it.toLatLng()) {} }
    map.setOnCameraChangeListener(object : TencentMap.OnCameraChangeListener {
      override fun onCameraChange(position: CameraPosition) {
        mapHandler.onCameraMove(position.toCameraPosition()) {}
      }

      override fun onCameraChangeFinished(position: CameraPosition) {
        mapHandler.onCameraIdle(position.toCameraPosition()) {}
      }
    })
    map.setOnMarkerClickListener {
      mapHandler.onTapMarker(it.id) {}
      true
    }
  }
}
