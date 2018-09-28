//
//  RXBaseRequest.m
//  Copyright © 2015年 Xuan. All rights reserved.
//

#import "RXBaseRequest.h"
#import "RXNetwork.h"
#import "MSDeviceInfo.h"
#import "MSNetworkStatusObserver.h"
#import "JYXUserManager.h"
#import "JYXLoginViewController.h"

static NSTimeInterval kRXNetworkingTimeoutSeconds = 30.0f;
NSString *RXStringFromAPIManagerErrorType(RXAPIManagerErrorType type) {
    switch (type) {
        case RXAPIManagerErrorTypeDefault:
            return @"API请求成功且返回数据正确";
            break;
        case RXAPIManagerErrorTypeNoContent:
            return @"API请求成功但返回数据不正确";
            break;
        case RXAPIManagerErrorTypeParamsError:
            return @"API请求参数错误";
            break;
        case RXAPIManagerErrorTypeTimeout:
            return @"API请求超时";
            break;
        case RXAPIManagerErrorTypeNoNetWork:
            return @"网络错误";
            break;
            
        default:
            return @"没有产生过API请求";
            break;
    }
}



@interface RXBaseRequest ()

@property (nonatomic, strong) RXURLResponse *response;
@property (nonatomic, readwrite) RXAPIManagerErrorType errorType;
@property (nonatomic, copy, readwrite) NSString *errorMessage;

// 默认参数
@property (nonatomic, strong) NSDictionary *defaultParams;
@property (nonatomic, strong) id fetchedRawData;

@end

@implementation RXBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _validator = nil;
        _fetchedRawData = nil;
        if ([self conformsToProtocol:@protocol(RXAPIManagerParams)]) {
            self.child = (NSObject <RXAPIManagerParams> *)self;
        }
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ ------> %@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
    [[RXNetwork sharedInstance] cancelRequestWithRequestID:@([self.dataTask taskIdentifier])];
}

#pragma mark - 请求 -
- (void)sendRequestWithCompletionBlockWithSuccess:(RXRequestCompletionBlock)success
                                          failure:(RXRequestCompletionBlock)failure
{
    if ([self.child respondsToSelector:@selector(requestParams:)]) {
        self.defaultParams = [self.child requestParams:self.defaultParams];
    }
    
    // 请求参数验证
    BOOL checkParams = [self.validator requestManager:self
                              isCorrectWithParamsData:self.defaultParams];
    if (!checkParams) {
        [self failedOnCallingAPI:nil
                   withErrorType:RXAPIManagerErrorTypeParamsError
                            fail:failure];
        return;
    }
    
    // 网络监测
    BOOL checkNetwork = [MSNetworkStatusObserver isNetworkEnable];
    if (!checkNetwork) {
        [self failedOnCallingAPI:nil
                   withErrorType:RXAPIManagerErrorTypeNoNetWork
                            fail:failure];
        return;
    }
    
    
    // 网络请求
    [[RXNetwork sharedInstance] sendRequest:self success:^(RXURLResponse *response) {
        
        self.response = response;
        
        if (response.content) {
            self.fetchedRawData = [response.content copy];
        } else {
            self.fetchedRawData = [response.responseData copy];
        }
        if ([self.fetchedRawData isKindOfClass:[NSDictionary class]]) {
            NSNumber *errorCode = self.fetchedRawData[@"code"];
            if (errorCode.integerValue == 1004) {
                [[JYXUserManager shareInstance].user clear];
                [[JYXUserManager shareInstance] save];
                JYXLoginViewController *login = [[JYXLoginViewController alloc] init];
                [kAppDelegate.window.rootViewController presentViewController:login animated:YES completion:nil];
            }
        }
        
        /// 其他请求
        if ([[self.child detailUrl] hasPrefix:@"http"]) {
            if (success) {
                success(self);
            }
            return ;
        }
        
        // 返回参数验证
        if ([self.validator requestManager:self
                 isCorrectWithCallBackData:response.content]) {
            
            if (success) {
                success(self);
            }
            
        } else {
            // 返回参数不正确
            [self failedOnCallingAPI:response
                       withErrorType:RXAPIManagerErrorTypeNoContent
                                fail:failure];
        }
        
    } fail:^(RXURLResponse *response) {
        
        [self failedOnCallingAPI:response
                   withErrorType:RXAPIManagerErrorTypeDefault
                            fail:failure];
    }];
}



#pragma mark - apiFailCallback
- (void)failedOnCallingAPI:(RXURLResponse *)response
             withErrorType:(RXAPIManagerErrorType)errorType
                      fail:(RXRequestCompletionBlock)fail
{
    //TODO: 解析错误码
    
    //TODO: 待优化
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)self.dataTask.response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    if (responseStatusCode == 403) {
        //        [[CPUserManager shareInstance].user clear];
        //        [[CPUserManager shareInstance] save];
        //        CPBaseViewController *vc = (CPBaseViewController *)[CPBaseViewController getCurrentVC];
        //        CPLoginViewController *login = [[CPLoginViewController alloc] init];
        //        [vc presentViewController:login animated:YES completion:nil];
    }
    
#ifdef DEBUG
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API error                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"errorStatus:\t%d\n\n", (int)errorType];
    [logString appendFormat:@"errorContent:\t%@\n\n", RXStringFromAPIManagerErrorType(errorType)];
    
    [logString appendFormat:@"messageContent:\t%@\n\n", response.content[@"message"]];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        error End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@", logString);
#endif
    
    self.errorType = errorType;
    self.errorMessage = response.content[@"message"];
    if (fail) {
        fail(self);
    }
}

- (NSTimeInterval)requestTimeoutInterval
{
    return kRXNetworkingTimeoutSeconds;
}

- (RXRequestSerializerType)requestSerializerType
{
    return RXRequestSerializerTypeHTTP;
}

- (NSDictionary <NSString *,NSString *> *)defaultHttpHeaderParams
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    return dict;
}

- (id)fetchDataWithReformer:(id <RXApiManagerDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(requestManager:reformData:)]) {
        resultData = [reformer requestManager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - getters and setters -
- (NSDictionary *)defaultParams
{
    if (!_defaultParams) {
        _defaultParams = [NSDictionary dictionary];
    }
    return _defaultParams;
}

- (id)requestParams
{
    return self.defaultParams;
}

- (id)responseJSONObject
{
    return self.response.content;
}

@end
