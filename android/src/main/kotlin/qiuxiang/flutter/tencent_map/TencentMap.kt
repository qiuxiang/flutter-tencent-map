package qiuxiang.flutter.tencent_map

import android.content.Context
import android.os.Handler
import android.view.View
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import com.tencent.tencentmap.mapsdk.maps.TencentMap as Map

class TencentMap(messenger: BinaryMessenger, context: Context) : PlatformView {
  private val listener = Pigeon.TencentMapListener(messenger)
  private val mapView = MapView(context)
  val map: Map = mapView.map
  val handler = Handler(context.mainLooper)

  init {
    mapView.onResume()
    Pigeon.TencentMapApi.setup(messenger, TencentMapApi(this))
    map.setOnMapClickListener { listener.onTap(it.toJson()) {} }
    map.setOnMapLongClickListener { latLng -> listener.onLongPress(latLng.toJson()) {} }
    map.setOnCameraChangeListener(object : Map.OnCameraChangeListener {
      override fun onCameraChange(position: CameraPosition) {
        handler.post { listener.onCameraMove(position.toJson()) {} }
      }

      override fun onCameraChangeFinished(position: CameraPosition) {
        listener.onCameraIdle(position.toJson()) {}
      }
    })
//    map.setOnMarkerClickListener { marker ->
//      channel.invokeMethod("onTapMarker", marker.id)
//      true
//    }
  }

  override fun getView(): View {
    return mapView
  }

  override fun dispose() {
    mapView.onDestroy()
  }
}
