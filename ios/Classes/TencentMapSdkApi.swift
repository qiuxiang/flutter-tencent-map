import QMapKit

class _TencentMapSdkApi: NSObject, TencentMapSdkApi {
    func initSdkIosApiKey(_ iosApiKey: String?, agreePrivacy: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if iosApiKey != nil {
            QMapServices.shared().apiKey = iosApiKey!
        }
        QMapServices.shared().setPrivacyAgreement(agreePrivacy.boolValue)
    }
}
