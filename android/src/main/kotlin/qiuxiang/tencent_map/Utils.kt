package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi

fun Map<*, *>.toLatLng(): LatLng {
  return LatLng(this["latitude"] as Double, this["longitude"] as Double)
}

fun LatLng.toLatLng(): Pigeon.LatLng {
  return Pigeon.LatLng.Builder()
    .setLatitude(latitude)
    .setLongitude(longitude)
    .build()
}

fun MapPoi.toMapPoi(): Pigeon.MapPoi {
  return Pigeon.MapPoi.Builder()
    .setName(name)
    .setPosition(position.toLatLng())
    .build()
}

fun Map<*, *>.toCameraPosition(): CameraPosition {
  val map = this
  return CameraPosition.Builder().apply {
    target((map["target"] as? Map<*, *>)?.toLatLng())
    map["tilt"].toFloat()?.let { tilt(it) }
    map["bearing"].toFloat()?.let { bearing(it) }
    map["zoom"].toFloat()?.let { zoom(it) }
  }.build()
}

fun Any?.toFloat(): Float? {
  return (this as? Double)?.toFloat()
}