package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.TencentMap.*
import qiuxiang.tencent_map.Pigeon.MapType

class TencentMapApi(tencentMap: TencentMap) : Pigeon.TencentMapApi {
  private val view = tencentMap.view
  private val map = tencentMap.map

  override fun setMapType(type: MapType) {
    map.mapType = when (type) {
      MapType.normal -> MAP_TYPE_NORMAL
      MapType.satellite -> MAP_TYPE_SATELLITE
      MapType.dark -> MAP_TYPE_DARK
    }
  }

  override fun pause() {
    view.onPause()
  }

  override fun resume() {
    view.onResume()
  }

  override fun start() {
    view.onStart()
  }

  override fun stop() {
    view.onStop()
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

  override fun moveCamera(json: MutableMap<Any, Any>, duration: Long) {
    val position = CameraUpdateFactory.newCameraPosition(json.toCameraPosition())
    if (duration > 0) {
      map.animateCamera(position, duration, null)
    } else {
      map.moveCamera(position)
    }
  }
}
