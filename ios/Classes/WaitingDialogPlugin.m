#import "WaitingDialogPlugin.h"
#import <waiting_dialog/waiting_dialog-Swift.h>

@implementation WaitingDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWaitingDialogPlugin registerWithRegistrar:registrar];
}
@end
