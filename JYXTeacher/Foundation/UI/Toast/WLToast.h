//
//  MSToast.h
//  hi7_client
//
//  Created by Michael Ge on 2016/10/21.
//  Copyright © 2016年 Beijing ShowMe Network Technology Co., Ltd.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLToast : NSObject

+ (void)show:(NSString*)text;
+ (void)showToCenter:(NSString *)text;


+ (void)showImageAndText:(NSString *)text;

/**
 成功的 带图片

 @param text 成功的文字
 */
//+ (void)showSuccess:(NSString *)text;

@end
