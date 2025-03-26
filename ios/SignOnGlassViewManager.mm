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

// Use direct command handling for Fabric
//RCT_EXPORT_METHOD(clearSignature:(nonnull NSNumber *)reactTag)
//{
//  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//      UIView *view = viewRegistry[reactTag];
//      if ([view isKindOfClass:[SignOnGlassView class]]) {
//        SignOnGlassView *signatureView = (SignOnGlassView *)view;
//        [signatureView clearSignature];
//      }
//    });
//  }];
//}

//RCT_EXPORT_METHOD(exposeSignature:(nonnull NSNumber *)reactTag)
//{
//  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//      UIView *view = viewRegistry[reactTag];
//      if ([view isKindOfClass:[SignOnGlassView class]]) {
//        SignOnGlassView *signatureView = (SignOnGlassView *)view;
//        [signatureView exposeSignature];
//      }
//    });
//  }];
//}

@end
