//
//  NSObject+Coder.h
//  通讯录
//
//  Created by HaoYoson on 16/7/10.
//  Copyright © 2016年 HaoYoson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (BOOL)isNotEmpty;

- (NSArray *)getPropertyList;

- (id)CT_defaultValue:(id)defaultData;
- (BOOL)CT_isEmptyObject;

@end
