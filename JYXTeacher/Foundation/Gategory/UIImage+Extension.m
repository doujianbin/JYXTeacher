//
//  TT.m
//  LakalaUILibrary
//
//  Created by lucongyu on 14-1-4.
//
//

#import "UIImage+Extension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Extension)

/**
 *  用颜色生成一个Image
 *
 *  @param color 颜色
 *  @param size  生成图片的大小
 *
 *  @return color生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  用颜色生成一个Image
 *
 *  @param color       主体颜色
 *  @param size        生成图片的大小
 *  @param bottomColor 底部颜色
 *  @param height      底部高
 *
 *  @return color生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size bottomColor:(UIColor *)bottomColor bottomHeight:(float)height
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextSetFillColorWithColor(context, bottomColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, size.height-height, size.width, height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  图片转换成颜色
 *
 *  @return 颜色
 */
- (UIColor *)color
{
    return [UIColor colorWithPatternImage:self];
}

/**
 *  图片中间拉伸生成新图片
 *
 *  @param size 生产图片的尺寸
 *
 *  @return 新图片
 */
- (UIImage *)scaleToSize:(CGSize)size
{
    return [self scaleToSize:size fromPoint:CGPointMake(self.size.width/2., self.size.height/2.)];
}

/**
 *  图片中间拉伸生成新图片
 *
 *  @param size 生产图片的尺寸
 *
 *  @return 新图片
 */
- (UIImage *)scaleToSize:(CGSize)size fromPoint:(CGPoint)point
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [[self stretchableImageWithLeftCapWidth:point.x topCapHeight:point.y] drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  等比例缩放
 *  @param scale   缩放比例
 *
 *  @return 缩放后的图像
 */
- (UIImage *)resizableImageWithScale:(float)scale
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width * scale,self.size.height * scale),
                                           NO,
                                           self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height *scale)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  剪裁图片大小
 *  @param rect  剪裁位置及大小
 *
 *  @return 剪裁后的图片
 */
- (UIImage* _Nonnull)imageWithClip:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    
    return [[UIImage alloc] initWithCGImage:imageRefRect scale:self.scale orientation:UIImageOrientationUp];
}

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

/**
 *  渐变色
 *  @param red              红色
 *  @param green            绿色
 *  @param blue             蓝色
 *  @param startAlpha       开始的透明度
 *  @param endAlpha         结束的透明度
 *  @param direction        那个方向
 *  @param frame            大小
 */
+ (UIImage *)LW_gradientColorWithRed:(CGFloat)red
                          green:(CGFloat)green
                           blue:(CGFloat)blue
                     startAlpha:(CGFloat)startAlpha
                       endAlpha:(CGFloat)endAlpha
                      direction:(DirectionStyle)direction
                          frame:(CGRect)frame
{
    //底部上下渐变效果背景
    // The following methods will only return a 8-bit per channel context in the DeviceRGB color space. 通过图片上下文设置颜色空间间
    UIGraphicsBeginImageContext(frame.size);
    //获得当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建颜色空间 /* Create a DeviceRGB color space. */
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    //通过矩阵调整空间变换
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    
    //通过颜色组件获得渐变上下文
    CGGradientRef backGradient;
    //253.0/255.0, 163.0/255.0, 87.0/255.0, 1.0,
    if (direction == DirectionStyleToUnder) {
        //向下
        //设置颜色 矩阵
        CGFloat colors[] = {
            red, green, blue, startAlpha,
            red, green, blue, endAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    } else {
        //向上
        CGFloat colors[] = {
            red, green, blue, endAlpha,
            red, green, blue, startAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    }
    
    //释放颜色渐变
    CGColorSpaceRelease(rgb);
    //通过上下文绘画线色渐变
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0.5, 0), CGPointMake(0.5, 1), kCGGradientDrawsBeforeStartLocation);
    //通过图片上下文获得照片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
