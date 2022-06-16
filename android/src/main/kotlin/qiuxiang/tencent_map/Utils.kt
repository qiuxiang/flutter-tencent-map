package qiuxiang.tencent_map

import android.graphics.BitmapFactory
import com.tencent.tencentmap.mapsdk.maps.model.*
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

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

fun Pigeon.MarkerOptions.toMarkerOptions(binding: FlutterPluginBinding): MarkerOptions {
  return MarkerOptions(position.toLatLng()).let { options ->
    icon?.toBitmapDescriptor(binding)?.let { options.icon(it) }
    rotation?.toFloat()?.let { options.rotation(it) }
    alpha?.toFloat()?.let { options.alpha(it) }
    flat?.let { options.flat(it) }
    anchor?.let { options.anchor(it[0].toFloat(), it[1].toFloat()) }
    draggable?.let { options.draggable(it) }
    zIndex?.let { options.zIndex(it.toFloat()) }
    options
  }
}

fun Pigeon.Bitmap.toBitmapDescriptor(binding: FlutterPluginBinding): BitmapDescriptor? {
  asset?.let {
    return BitmapDescriptorFactory.fromAsset(binding.flutterAssets.getAssetFilePathByName(it))
  }
  bytes?.let {
    return BitmapDescriptorFactory.fromBitmap(BitmapFactory.decodeByteArray(it, 0, it.size))
  }
  return null
}