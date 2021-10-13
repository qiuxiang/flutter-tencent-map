package qiuxiang.flutter.tencent_map

import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi

fun List<*>.toLatLng(): LatLng {
  return LatLng(this[0] as Double, this[1] as Double)
}

fun LatLng.toJson(): List<Double> {
  return listOf(this.latitude, this.longitude)
}

fun MapPoi.toJson(): Map<Any, Any> {
  return mapOf("position" to position.toJson(), "name" to name)
}

fun Map<*, *>.toMapStatus(): CameraPosition {
  val map = this
  return CameraPosition.Builder().apply {
    target((map["target"] as? List<*>)?.toLatLng())
    map["tilt"].toFloat()?.let { tilt(it) }
    map["bearing"].toFloat()?.let { bearing(it) }
    map["zoom"].toFloat()?.let { zoom(it) }
  }.build()
}

fun CameraPosition.toJson(): Map<Any, Any> {
  return mapOf("target" to target.toJson(), "tilt" to tilt, "bearing" to bearing, "zoom" to zoom)
}

fun Any?.toFloat(): Float? {
  return (this as? Double)?.toFloat()
}
