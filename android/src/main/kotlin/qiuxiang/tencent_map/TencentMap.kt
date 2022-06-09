package qiuxiang.tencent_map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class TencentMap(messenger: BinaryMessenger, context: Context?) : PlatformView {
  private val handler = Pigeon.TencentMapHandler(messenger)
  private val view = TextureMapView(context!!)
  val map: TencentMap = view.map

  override fun getView(): MapView {
    return view
  }

  override fun dispose() {}

  init {
    view.onResume()
    Pigeon.TencentMapApi.setup(messenger, TencentMapApi(this))
    map.setOnMapClickListener { handler.onTap(it.toLatLng()) {} }
    map.setOnMapPoiClickListener { handler.onTapPoi(it.toMapPoi()) {} }
    map.setOnMapLongClickListener { handler.onLongPress(it.toLatLng()) {} }
    map.setOnCameraChangeListener(object : TencentMap.OnCameraChangeListener {
      override fun onCameraChange(position: CameraPosition) {
        handler.onCameraMove(position.toCameraPosition()) {}
      }

      override fun onCameraChangeFinished(position: CameraPosition) {
        handler.onCameraIdle(position.toCameraPosition()) {}
      }
    })
  }
}
