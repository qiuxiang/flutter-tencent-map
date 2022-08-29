package qiuxiang.tencent_map

import android.content.Context
import android.location.Location
import com.tencent.map.geolocation.TencentLocation
import com.tencent.map.geolocation.TencentLocationListener
import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.map.geolocation.TencentLocationRequest
import com.tencent.tencentmap.mapsdk.maps.BaseMapView
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(val binding: FlutterPlugin.FlutterPluginBinding, context: Context, args: HashMap<*, *>) :
  PlatformView {
  private val mapHandler = Pigeon.TencentMapHandler(binding.binaryMessenger)
  private val mapView: BaseMapView
  val markers = mutableMapOf<String, Marker>()

  override fun getView(): BaseMapView {
    return mapView
  }

  override fun dispose() {}

  init {
    mapView = if (args["texture"] as Boolean) {
      TextureMapView(context)
    } else {
      MapView(context)
    }
    val mapApi = TencentMapApi(this)
    Pigeon.TencentMapApi.setup(binding.binaryMessenger, mapApi)
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
    val locationManager = TencentLocationManager.getInstance(context)
    val request = TencentLocationRequest.create()
    locationManager.requestLocationUpdates(request, object : TencentLocationListener {
      override fun onLocationChanged(location: TencentLocation?, p1: Int, p2: String?) {
        if (location == null || (location.latitude == 0.0 && location.longitude == 0.0)) return

        mapApi.locationListener?.onLocationChanged(Location("").apply {
          latitude = location.latitude
          longitude = location.longitude
          accuracy = location.accuracy
          bearing = location.bearing
        })
        val pigeonLocation = Pigeon.Location.Builder().setLatitude(location.latitude).setLongitude(location.longitude)
          .setAccuracy(location.accuracy.toDouble()).setBearing(location.bearing.toDouble()).build()
        mapHandler.onLocation(pigeonLocation) {}
      }

      override fun onStatusUpdate(p0: String?, p1: Int, p2: String?) {
      }
    })
  }
}
