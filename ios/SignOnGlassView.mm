#import "SignOnGlassView.h"
#import <PencilKit/PencilKit.h>

#import "generated/RNSignOnGlassViewSpec/ComponentDescriptors.h"
#import "generated/RNSignOnGlassViewSpec/EventEmitters.h"
#import "generated/RNSignOnGlassViewSpec/Props.h"
#import "generated/RNSignOnGlassViewSpec/RCTComponentViewHelpers.h"

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@interface SignOnGlassView () <RCTSignOnGlassViewViewProtocol>
@property (nonatomic, strong) PKCanvasView *canvasView;
@property (nonatomic, assign) CGFloat pencilWeight;

@end

@implementation SignOnGlassView {
    UIView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<SignOnGlassViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        static const auto defaultProps = std::make_shared<const SignOnGlassViewProps>();
        _props = defaultProps;
        
        // Initialize PKCanvasView
        _pencilWeight = 2.0;
        
        // Initialize PKCanvasView
        _canvasView = [[PKCanvasView alloc] initWithFrame:self.bounds];
        _canvasView.delegate = self;
        _canvasView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _canvasView.backgroundColor = [UIColor clearColor];
        
        _canvasView.drawingPolicy = PKCanvasViewDrawingPolicyAnyInput; // Allow drawing with finger or pencil
        _canvasView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // Set the tool with fixed properties
        PKInkingTool *inkingTool = [[PKInkingTool alloc] initWithInkType:PKInkTypePen color:[UIColor blackColor] width:_pencilWeight];
        _canvasView.tool = inkingTool;
        
        self.contentView = _canvasView;
        
        // Enable user interaction
        _canvasView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    //    const auto &oldViewProps = *std::static_pointer_cast<SignOnGlassViewProps const>(_props);
    //    const auto &newViewProps = *std::static_pointer_cast<SignOnGlassViewProps const>(props);
    //
    //    if (oldViewProps.color != newViewProps.color) {
    //        NSString * colorToConvert = [[NSString alloc] initWithUTF8String: newViewProps.color.c_str()];
    //        UIColor *newColor = [self hexStringToColor:colorToConvert];
    //        _canvasView.tool = [[PKInkingTool alloc] initWithInkType:PKInkTypePen color:newColor width:self.pencilWeight];
    //        _canvasView.backgroundColor = newColor;
    //    }
    
    //   if (oldViewProps.pencilWeight != newViewProps.pencilWeight) {
    //       self.pencilWeight = newViewProps.pencilWeight;
    //       _canvasView.tool = [[PKInkingTool alloc] initWithInkType:PKInkTypePen color:_canvasView.tool.color width:self.pencilWeight];
    //   }
    
    [super updateProps:props oldProps:oldProps];
}


- hexStringToColor:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *stringScanner = [NSScanner scannerWithString:noHashString];
    
    unsigned hex;
    if (![stringScanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

#pragma mark - PKCanvasViewDelegate Methods

- (void)canvasViewDidBeginUsingTool:(PKCanvasView *)canvasView {
    if (_eventEmitter) {
        // std::dynamic_pointer_cast<const facebook::react::EventEmitter>(_eventEmitter)
        //     ->dispatchEvent("drawingStarted", folly::dynamic::object());
        
        std::dynamic_pointer_cast<const facebook::react::SignOnGlassViewEventEmitter>(_eventEmitter)
        ->onDrawingStarted({});
    }
}

- (void)clearSignature {
    _canvasView.drawing = [[PKDrawing alloc] init];
}

- (void) exposeSignature {
    NSString *base64Image = [self exposeSignatureToBase64];
    // Emit an event with the image data
    if (_eventEmitter) {
        std::dynamic_pointer_cast<const facebook::react::EventEmitter>(_eventEmitter)
        ->dispatchEvent("signatureExposed", folly::dynamic::object("signature", [base64Image UTF8String]));
        
    }
}

- (NSString *)exposeSignatureToBase64 {
    // Get the drawing as an image
    UIImage *signatureImage = [_canvasView.drawing imageFromRect:_canvasView.bounds
                                                           scale:1.0];
    
    if (!signatureImage) {
        return @"";
    }
    
    // Convert image to PNG data
    NSData *imageData = UIImagePNGRepresentation(signatureImage);
    
    // Convert to base64 string
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    return base64String;
}


- (void)handleCommand:(const NSString *)commandName args:(const NSArray *)args
{
    RCTSignOnGlassViewHandleCommand(self, commandName, args);
}

@end

Class<RCTComponentViewProtocol> SignOnGlassViewCls(void)
{
    return SignOnGlassView.class;
}
