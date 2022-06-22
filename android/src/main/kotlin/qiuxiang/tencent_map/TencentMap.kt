package qiuxiang.tencent_map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.LocationSource
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(val binding: FlutterPlugin.FlutterPluginBinding, context: Context?) : PlatformView {
  private val mapHandler = Pigeon.TencentMapHandler(binding.binaryMessenger)
  private val mapView = MapView(context!!)
  val markers = mutableMapOf<String, Marker>()

  override fun getView(): MapView {
    return mapView
  }

  override fun dispose() {}

  init {
    Pigeon.TencentMapApi.setup(binding.binaryMessenger, TencentMapApi(this))
    Pigeon.MarkerApi.setup(binding.binaryMessenger, MarkerApi(this))
    mapView.onResume()
    mapView.map.setOnMapClickListener { mapHandler.onTap(it.toLatLng()) {} }
    mapView.map.setOnMapPoiClickListener { mapHandler.onTapPoi(it.toMapPoi()) {} }
    mapView.map.setOnMapLongClickListener { mapHandler.onLongPress(it.toLatLng()) {} }
    mapView.map.setOnCameraChangeListener(object : TencentMap.OnCameraChangeListener {
      override fun onCameraChange(position: CameraPosition) {
        mapHandler.onCameraMove(position.toCameraPosition()) {}
      }

      override fun onCameraChangeFinished(position: CameraPosition) {
        mapHandler.onCameraIdle(position.toCameraPosition()) {}
      }
    })
    mapView.map.setOnMarkerClickListener {
      mapHandler.onTapMarker(it.id) {}
      true
    }
    mapView.map.setOnMarkerDragListener(object : TencentMap.OnMarkerDragListener {
      override fun onMarkerDragStart(marker: Marker) {
        mapHandler.onMarkerDragStart(marker.id, marker.position.toLatLng()) {}
      }

      override fun onMarkerDrag(marker: Marker) {
        mapHandler.onMarkerDrag(marker.id, marker.position.toLatLng()) {}
      }

      override fun onMarkerDragEnd(marker: Marker) {
        mapHandler.onMarkerDragEnd(marker.id, marker.position.toLatLng()) {}
      }
    })
  }
}
