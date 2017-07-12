//
//  WELStatusbarIconColor.m
//  StatusbarColor
//
//  Created by WELCommand on 2017/7/5.
//  Copyright © 2017年 WELCommand. All rights reserved.
//

#import "WELCustomStatusbarColor.h"
#import <objc/runtime.h>

#define WELSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


@interface UIImage (WELStatusbarIconColor)

- (UIImage *)wel_imageWithColor:(UIColor *)color;

@end

@implementation UIImage (WELStatusbarIconColor)

- (UIImage *)wel_imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end



id wel_imageHook(id self, SEL _cmd, UIImage *image, UIImage *shadowImage) {
    UIColor *color = objc_getAssociatedObject([WELCustomStatusbarColor class], @"wel_statusbarIconColor");
    if(color) {
        image = [image wel_imageWithColor:color];
        shadowImage = [shadowImage wel_imageWithColor:color];
    }
    WELSuppressPerformSelectorLeakWarning(
                                          id obj = [self performSelector:NSSelectorFromString(@"wel_imageFromImage:withShadowImage:") withObject:image withObject:shadowImage];
                                          return obj;
                                          );
    
}

id wel__accessoryImage(id self, SEL _cmd) {
    
    UIImage *image;
    WELSuppressPerformSelectorLeakWarning(
                                          image= [self performSelector:NSSelectorFromString(@"wel__accessoryImage")];
                                          );
    
    UIColor *color = objc_getAssociatedObject([WELCustomStatusbarColor class], @"wel_statusbarIconColor");
    if(color) {
        image = [image wel_imageWithColor:color];
    }
    
    return image;
}

UIColor* wel_tintColor(id self, SEL _cmd) {
    
    UIColor *color = objc_getAssociatedObject([WELCustomStatusbarColor class], @"wel_statusbarIconColor");
    if (color) {
        return color;
    }
    WELSuppressPerformSelectorLeakWarning (
    return [self performSelector:NSSelectorFromString(@"wel_tintColor")];
                                           );
    
}

@implementation WELCustomStatusbarColor

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        Method  m = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"), NSSelectorFromString(@"imageFromImage:withShadowImage:"));
        
        class_addMethod(object_getClass((id)NSClassFromString(@"_UILegibilityImageSet")), NSSelectorFromString(@"wel_imageFromImage:withShadowImage:"), (IMP)wel_imageHook, method_getTypeEncoding(m));
        
        Method m1 = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"),NSSelectorFromString(@"imageFromImage:withShadowImage:"));
        Method m2 = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"), NSSelectorFromString(@"wel_imageFromImage:withShadowImage:"));
        method_exchangeImplementations(m1,m2);
        
        //
        m = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"_accessoryImage"));
        
        class_addMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"wel__accessoryImage"), (IMP)wel__accessoryImage, method_getTypeEncoding(m));
        
        m1 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"),NSSelectorFromString(@"_accessoryImage"));
        m2 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"wel__accessoryImage"));
        method_exchangeImplementations(m1,m2);
        
        //
        m = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"tintColor"));
        
        class_addMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"wel_tintColor"), (IMP)wel_tintColor, method_getTypeEncoding(m));
        
        m1 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"),NSSelectorFromString(@"tintColor"));
        m2 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"wel_tintColor"));
        method_exchangeImplementations(m1,m2);
        
    });
}

+ (void)updateStatusbarIconColor:(UIColor *)color {
    objc_setAssociatedObject([self class], @"wel_statusbarIconColor", color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UIApplication sharedApplication].keyWindow.rootViewController setNeedsStatusBarAppearanceUpdate];
}


@end


@interface UIViewController (StatusBarColor)
@end
@interface UINavigationController (StatusBarColor)
@end


@implementation UIViewController (StatusBarColor)

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    NSInteger style = [objc_getAssociatedObject([UIViewController class], @"wel_preferredStatusBarStyle") integerValue];
    
    objc_setAssociatedObject([UIViewController class], @"wel_preferredStatusBarStyle", @(!style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return  style ? 1: 0;
}

@end

@implementation UINavigationController (StatusBarColor)

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
