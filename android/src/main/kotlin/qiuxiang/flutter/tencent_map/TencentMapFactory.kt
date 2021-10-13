package qiuxiang.flutter.tencent_map

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec.INSTANCE
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TencentMapFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(INSTANCE) {
  override fun create(context: Context, id: Int, args: Any?): PlatformView {
    return TencentMap(messenger, context)
  }
}
