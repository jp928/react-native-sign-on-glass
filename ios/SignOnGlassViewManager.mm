#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface SignOnGlassViewManager : RCTViewManager
@end

@implementation SignOnGlassViewManager

RCT_EXPORT_MODULE(SignOnGlassView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end
