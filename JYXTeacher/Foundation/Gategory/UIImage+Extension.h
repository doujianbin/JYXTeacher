//
//  TT.h
//  LakalaUILibrary
//
//  Created by lucongyu on 14-1-4.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DirectionStyle){
    DirectionStyleToUnder = 0,  //向下
    DirectionStyleToUn = 1      //向上
};

@interface UIImage (Extension)

/**
 *  用颜色生成一个Image
 *
 *  @param color 颜色
 *  @param size  生成图片的大小
 *
 *  @return color生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

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
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size bottomColor:(UIColor *)bottomColor bottomHeight:(float)height;

/**
 *  图片转换成颜色
 *
 *  @return 颜色
 */
- (UIColor *)color;

/**
 *  图片中间拉伸生成新图片
 *
 *  @param size 生产图片的尺寸
 *
 *  @return 新图片
 */
- (UIImage *)scaleToSize:(CGSize)size;


/**
 *  图片中间拉伸生成新图片
 *
 *  @param size 生产图片的尺寸
 *
 *  @return 新图片
 */
- (UIImage *)scaleToSize:(CGSize)size fromPoint:(CGPoint)point;

/**
 *  等比例缩放
 *  @param scale   缩放比例
 *
 *  @return 缩放后的图像
 */
- (UIImage *)resizableImageWithScale:(float)scale;

/**
 *  剪裁图片大小
 *  @param rect  剪裁位置及大小
 *
 *  @return 剪裁后的图片
 */
- (UIImage *)imageWithClip:(CGRect)rect;

/**
 获取网络图片的大小

 @param URL 网络图片URL
 @return 网络图片的大小
 */
+ (CGSize)getImageSizeWithURL:(id)URL;

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
                               frame:(CGRect)frame;

@end
