//
//  RXNetwork.h
//  Copyright © 2015年 Xuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXBaseRequest.h"
#import "RXURLResponse.h"

@interface RXNetwork : NSObject


typedef void(^RXCallback)(RXURLResponse *response);

+ (instancetype)sharedInstance;

- (void)sendRequest:(RXBaseRequest *)request success:(RXCallback)success fail:(RXCallback)fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

@end
