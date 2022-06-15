package qiuxiang.tencent_map

class MarkerApi(private val tencentMap: TencentMap) : Pigeon.MarkerApi {
  override fun remove(id: String) {
    val marker = tencentMap.markers[id]
    if (marker != null) {
      marker.remove()
      tencentMap.markers.remove(id)
    }
  }
}