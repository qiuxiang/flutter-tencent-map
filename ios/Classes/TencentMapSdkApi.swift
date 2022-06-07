import QMapKit

class _TencentMapSdkApi: NSObject, TencentMapSdkApi {
    func initSdkIosApiKey(_ iosApiKey: String, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        QMapServices.shared().apiKey = iosApiKey
        QMapServices.shared().setPrivacyAgreement(true)
    }
}
