//
//  NSURLRequest+Extension.m
//  YiXiuGe
//
//  Created by liruixuan on 17/3/31.
//  Copyright © 2017年 YiXiuGe. All rights reserved.
//

#import "NSURLRequest+Extension.h"
#import <objc/runtime.h>

static void *RXNetworkingRequestParams;

@implementation NSURLRequest (Extension)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &RXNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &RXNetworkingRequestParams);
}

@end
