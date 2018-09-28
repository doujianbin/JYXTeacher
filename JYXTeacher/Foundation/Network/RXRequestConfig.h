//
//  RXRequestConfig.h
//  YiXiuGe
//
//  Created by liruixuan on 17/3/30.
//  Copyright © 2017年 YiXiuGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXBaseRequest.h"

@interface RXRequestConfig : NSObject

+ (instancetype)sharedInstance;
+ (void)setServerAddress:(id)address;
- (NSURLRequest *)requestWithRXRequest:(RXBaseRequest *)request;

@end
