//
//  MSToast.m
//  hi7_client
//
//  Created by Michael Ge on 2016/10/21.
//  Copyright © 2016年 Beijing ShowMe Network Technology Co., Ltd.,. All rights reserved.
//

#import "WLToast.h"
#import "UIView+Toast.h"


@implementation WLToast

+ (void)show:(NSString *)text
{
    [([UIApplication sharedApplication].delegate).window hideToasts];
//    float x = [UIScreen mainScreen].bounds.size.width/2.0f;
//    id point = [NSValue valueWithCGPoint:CGPointMake(x, 64+20)];
    [([UIApplication sharedApplication].delegate).window  makeToast:text
                                                                   duration:2
                                                                   position:CSToastPositionCenter];
}

+ (void)showToCenter:(NSString *)text
{
    //    float x = [UIScreen mainScreen].bounds.size.width/2.0f;
    //    id point = [NSValue valueWithCGPoint:CGPointMake(x, 64+20)];
    [([UIApplication sharedApplication].delegate).window  makeToast:text
                                                                   duration:2
                                                                   position:CSToastPositionCenter];
}

+ (void)showImageAndText:(NSString *)text
{
    //    float x = [UIScreen mainScreen].bounds.size.width/2.0f;
    //    id point = [NSValue valueWithCGPoint:CGPointMake(x, 64+20)];
    
    
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] makeToast:text
//                                                                  duration:2
//                                                                  position:CSToastPositionBottom
//                                                                     image:[UIImage imageNamed:@"headIMG_placeholderImage"]];
    
//    [[[UIApplication sharedApplication].windows objectAtIndex:0]  makeToast:text
//                                                                   duration:2
//                                                                   position:CSToastPositionTopMaxPadding];
}

//+(void)showSuccess:(NSString *)text
//{
//    [MBProgressHUD showSuccess:text];
//}


@end
