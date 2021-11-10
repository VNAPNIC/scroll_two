#import "ScrollTwoPlugin.h"
#if __has_include(<scroll_two/scroll_two-Swift.h>)
#import <scroll_two/scroll_two-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "scroll_two-Swift.h"
#endif

@implementation ScrollTwoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScrollTwoPlugin registerWithRegistrar:registrar];
}
@end
