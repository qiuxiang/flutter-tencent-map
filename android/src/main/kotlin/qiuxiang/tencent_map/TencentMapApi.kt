package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.LocationSource
import com.tencent.tencentmap.mapsdk.maps.TencentMap.*
import qiuxiang.tencent_map.Pigeon.MapType

class TencentMapApi(private val tencentMap: TencentMap) : Pigeon.TencentMapApi {
  private val mapView = tencentMap.view
  var locationListener: LocationSource.OnLocationChangedListener? = null

  init {
    mapView.map.setLocationSource(object : LocationSource {
      override fun deactivate() {}
      override fun activate(listener: LocationSource.OnLocationChangedListener) {
        locationListener = listener
      }
    })
  }

  override fun setMapType(type: MapType) {
    mapView.map.mapType = when (type) {
      MapType.normal -> MAP_TYPE_NORMAL
      MapType.satellite -> MAP_TYPE_SATELLITE
      MapType.dark -> MAP_TYPE_DARK
    }
  }

  override fun pause() {
    mapView.onPause()
  }

  override fun resume() {
    mapView.onResume()
  }

  override fun destory() {
    mapView.onDestroy()
  }

  override fun setCompassEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isCompassEnabled = enabled
  }

  override fun setRotateGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isRotateGesturesEnabled = enabled
  }

  override fun setScrollGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScrollGesturesEnabled = enabled
  }

  override fun setZoomGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isZoomGesturesEnabled = enabled
  }

  override fun setTiltGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isTiltGesturesEnabled = enabled
  }

  override fun setIndoorViewEnabled(enabled: Boolean) {
    mapView.map.setIndoorEnabled(enabled)
  }

  override fun setTrafficEnabled(enabled: Boolean) {
    mapView.map.isTrafficEnabled = enabled
  }

  override fun setBuildingsEnabled(enabled: Boolean) {
    mapView.map.showBuilding(enabled)
  }

  override fun setScaleControlsEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScaleViewEnabled = enabled
  }

  override fun setMyLocationButtonEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isMyLocationButtonEnabled = enabled
  }

  override fun setMyLocationEnabled(enabled: Boolean) {
    mapView.map.isMyLocationEnabled = enabled
  }

  override fun setMyLocation(location: Pigeon.Location) {
    locationListener?.onLocationChanged(location.toLocation())
  }

  override fun setMyLocationStyle(style: Pigeon.MyLocationStyle) {
    mapView.map.setMyLocationStyle(style.toMyLocationStyle())
  }

  override fun moveCamera(position: Pigeon.CameraPosition, duration: Long) {
    val cameraPosition = position.toCameraPosition(mapView.map.cameraPosition)
    val cameraUpdate = CameraUpdateFactory.newCameraPosition(cameraPosition)
    if (duration > 0) {
      mapView.map.stopAnimation()
      mapView.map.animateCamera(cameraUpdate, duration, null)
    } else {
      mapView.map.moveCamera(cameraUpdate)
    }
  }

  override fun addMarker(options: Pigeon.MarkerOptions): String {
    val marker = mapView.map.addMarker(options.toMarkerOptions(tencentMap.binding))
    tencentMap.markers[marker.id] = marker
    return marker.id
  }

  override fun addPolyline(options: Pigeon.PolylineOptions): String {
    TODO("Not yet implemented")
  }
}
