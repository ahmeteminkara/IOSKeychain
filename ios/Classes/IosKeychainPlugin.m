#import "IosKeychainPlugin.h"
#if __has_include(<ios_keychain/ios_keychain-Swift.h>)
#import <ios_keychain/ios_keychain-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ios_keychain-Swift.h"
#endif

@implementation IosKeychainPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIosKeychainPlugin registerWithRegistrar:registrar];
}
@end
