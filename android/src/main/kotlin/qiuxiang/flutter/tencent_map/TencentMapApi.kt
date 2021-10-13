package qiuxiang.flutter.tencent_map

import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory

class TencentMapApi(tencentMap: TencentMap) : Pigeon.TencentMapApi {
  private val map = tencentMap.map

  override fun setMapType(type: Long) {
    map.mapType = type.toInt()
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

  override fun setZoomControlsEnabled(enabled: Boolean) {
    map.uiSettings.isZoomControlsEnabled = enabled
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
    val position = CameraUpdateFactory.newCameraPosition(json.toMapStatus())
    if (duration > 0) {
      map.animateCamera(position, duration, null)
    } else {
      map.moveCamera(position)
    }
  }
}
