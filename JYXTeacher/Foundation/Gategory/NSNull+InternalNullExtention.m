//
//  NSNull+InternalNullExtention.m
//  FHMall
//
//  Created by liruixuan on 16/6/23.
//  Copyright © 2016年 FangLin. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"

@implementation NSNull (InternalNullExtention)

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
