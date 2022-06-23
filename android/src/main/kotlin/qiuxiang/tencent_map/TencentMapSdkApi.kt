package qiuxiang.tencent_map

import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer

class TencentMapSdkApi : Pigeon.TencentMapSdkApi {
  override fun initSdk(iosApiKey: String?, agreePrivacy: Boolean) {
    TencentMapInitializer.setAgreePrivacy(agreePrivacy)
  }
}
