package qiuxiang.tencent_map

class MarkerApi(tencentMap: TencentMap) : Pigeon.MarkerApi {
  private val binding = tencentMap.binding
  private val markers = tencentMap.markers

  override fun remove(id: String) {
    val marker = markers[id]
    if (marker != null) {
      marker.remove()
      markers.remove(id)
    }
  }

  override fun setPosition(id: String, position: Pigeon.LatLng) {
    markers[id]?.position = position.toLatLng()
  }

  override fun setZIndex(id: String, zIndex: Long) {
    markers[id]?.zIndex = zIndex.toInt()
  }

  override fun setAnchor(id: String, x: Double, y: Double) {
    markers[id]?.setAnchor(x.toFloat(), y.toFloat())
  }

  override fun setIcon(id: String, icon: Pigeon.Bitmap) {
    icon.toBitmapDescriptor(binding)?.let { markers[id]?.setIcon(it) }
  }

  override fun setDraggable(id: String, draggable: Boolean) {
    markers[id]?.isDraggable = draggable
  }

  override fun setAlpha(id: String, alpha: Double) {
    markers[id]?.alpha = alpha.toFloat()
  }

  override fun setRotation(id: String, rotation: Double) {
    markers[id]?.rotation = rotation.toFloat()
  }
}