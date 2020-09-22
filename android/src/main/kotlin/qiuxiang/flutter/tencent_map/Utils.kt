package qiuxiang.flutter.tencent_map

import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi

fun ArrayList<*>.toLatLng(): LatLng {
  return LatLng(this[0] as Double, this[1] as Double)
}

fun LatLng.toJson(): ArrayList<Double> {
  return arrayListOf(this.latitude, this.longitude)
}

fun MapPoi.toJson(): HashMap<String, Any> {
  this.let {
    return HashMap<String, Any>().apply {
      set("position", it.position.toJson())
      set("name", it.name)
    }
  }
}

fun CameraPosition.toJson(): HashMap<String, Any> {
  this.let {
    return HashMap<String, Any>().apply {
      set("bearing", it.bearing)
      set("target", it.target.toJson())
      set("tilt", it.tilt)
      set("zoom", it.zoom)
    }
  }
}
