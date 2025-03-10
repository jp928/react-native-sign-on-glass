#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"
#import "SignOnGlassView.h"
#import <PencilKit/PencilKit.h>

@interface SignOnGlassViewManager : RCTViewManager
@end

@implementation SignOnGlassViewManager

RCT_EXPORT_MODULE(SignOnGlassView)

- (UIView *)view
{
  return [[SignOnGlassView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)
RCT_EXPORT_VIEW_PROPERTY(pencilWeight, CGFloat)

@end
