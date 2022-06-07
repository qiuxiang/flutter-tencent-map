import Flutter

public class SwiftTencentMapPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(TencentMapFactory(registrar: registrar), withId: "tencent_map")
        TencentMapSdkApiSetup(registrar.messenger(), _TencentMapSdkApi())
    }
}
	
