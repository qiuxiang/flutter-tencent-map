#import "TencentMapPlugin.h"
#if __has_include(<tencent_map/tencent_map-Swift.h>)
#import <tencent_map/tencent_map-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tencent_map-Swift.h"
#endif

@implementation TencentMapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTencentMapPlugin registerWithRegistrar:registrar];
}
@end
