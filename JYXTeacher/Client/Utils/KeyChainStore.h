//
//  KeyChainStore.h
//  DocChat-C-iphone
//
//  Created by 于世民 on 2017/4/5.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
