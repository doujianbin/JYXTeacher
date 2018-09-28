//
//  RXNetworkLog.h
//  YiXiuGe
//
//  Created by liruixuan on 17/3/30.
//  Copyright © 2017年 YiXiuGe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXNetworkLog : NSObject

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;

@end
