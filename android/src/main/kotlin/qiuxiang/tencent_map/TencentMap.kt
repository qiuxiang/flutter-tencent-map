package qiuxiang.tencent_map

import android.content.Context
import android.view.View
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import io.flutter.plugin.platform.PlatformView

class TencentMap(context: Context?, viewId: Int) : PlatformView {
  private val view = TextureMapView(context!!)

  override fun getView(): View {
    return view
  }

  override fun dispose() {}

  init {
    view.onResume()
    view.map.uiSettings.isRotateGesturesEnabled = false
    view.map.uiSettings.isTiltGesturesEnabled = false
  }
}
