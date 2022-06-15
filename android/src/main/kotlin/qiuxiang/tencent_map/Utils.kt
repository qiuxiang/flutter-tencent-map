package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.maps.model.MarkerOptions

fun Pigeon.LatLng.toLatLng(): LatLng {
  return LatLng(latitude, longitude)
}

fun LatLng.toLatLng(): Pigeon.LatLng {
  return Pigeon.LatLng.Builder().setLatitude(latitude).setLongitude(longitude).build()
}

fun MapPoi.toMapPoi(): Pigeon.MapPoi {
  return Pigeon.MapPoi.Builder().setName(name).setPosition(position.toLatLng()).build()
}

fun CameraPosition.toCameraPosition(): Pigeon.CameraPosition {
  return Pigeon.CameraPosition.Builder().setBearing(bearing.toDouble()).setTarget(target.toLatLng())
    .setTilt(tilt.toDouble()).setZoom(zoom.toDouble()).build()
}

fun Pigeon.CameraPosition.toCameraPosition(): CameraPosition {
  return CameraPosition.Builder().let { builder ->
    builder.target(target?.toLatLng())
    tilt?.toFloat()?.let { builder.tilt(it) }
    bearing?.toFloat()?.let { builder.bearing(it) }
    zoom?.toFloat()?.let { builder.zoom(it) }
    builder.build()
  }
}

fun Pigeon.MarkerOptions.toMarkerOptions(): MarkerOptions {
  return MarkerOptions(position.toLatLng()).let {
    it
  }
}
