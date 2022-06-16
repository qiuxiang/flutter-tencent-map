package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.TencentMap.*
import qiuxiang.tencent_map.Pigeon.MapType

class TencentMapApi(private val tencentMap: TencentMap) : Pigeon.TencentMapApi {
  private val map = tencentMap.map
  private val mapView = tencentMap.view

  override fun setMapType(type: MapType) {
    map.mapType = when (type) {
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

  override fun start() {
    mapView.onStart()
  }

  override fun stop() {
    mapView.onStop()
  }

  override fun setCompassEnabled(enabled: Boolean) {
    map.uiSettings.isCompassEnabled = enabled
  }

  override fun setRotateGesturesEnabled(enabled: Boolean) {
    map.uiSettings.isRotateGesturesEnabled = enabled
  }

  override fun setScrollGesturesEnabled(enabled: Boolean) {
    map.uiSettings.isScrollGesturesEnabled = enabled
  }

  override fun setZoomGesturesEnabled(enabled: Boolean) {
    map.uiSettings.isZoomGesturesEnabled = enabled
  }

  override fun setTiltGesturesEnabled(enabled: Boolean) {
    map.uiSettings.isTiltGesturesEnabled = enabled
  }

  override fun setIndoorViewEnabled(enabled: Boolean) {
    map.setIndoorEnabled(enabled)
  }

  override fun setTrafficEnabled(enabled: Boolean) {
    map.isTrafficEnabled = enabled
  }

  override fun setBuildingsEnabled(enabled: Boolean) {
    map.showBuilding(enabled)
  }

  override fun setScaleControlsEnabled(enabled: Boolean) {
    map.uiSettings.isScaleViewEnabled = enabled
  }

  override fun moveCamera(position: Pigeon.CameraPosition, duration: Long) {
    val cameraUpdate = CameraUpdateFactory.newCameraPosition(position.toCameraPosition())
    if (duration > 0) {
      map.animateCamera(cameraUpdate, duration, null)
    } else {
      map.moveCamera(cameraUpdate)
    }
  }

  override fun addMarker(options: Pigeon.MarkerOptions): String {
    val marker = map.addMarker(options.toMarkerOptions(tencentMap.binding))
    tencentMap.markers[marker.id] = marker
    return marker.id
  }
}
