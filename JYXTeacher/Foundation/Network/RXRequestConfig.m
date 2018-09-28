//
//  RXRequestConfig.m
//  YiXiuGe
//
//  Created by liruixuan on 17/3/30.
//  Copyright © 2017年 YiXiuGe. All rights reserved.
//

#import "RXRequestConfig.h"
#import <AFNetworking/AFNetworking.h>
#import "MSDeviceInfo.h"
#import "NSURLRequest+Extension.h"

static NSString *serverAddress;

@interface RXRequestConfig ()

@end

@implementation RXRequestConfig

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)setServerAddress:(id)address
{
    serverAddress = [address valueForKey:@"msvr://"];
}

- (NSURLRequest *)requestWithRXRequest:(RXBaseRequest *)request
{
    AFHTTPRequestSerializer *httpRequestSerializer = [self requestSerializerForRequest:request];
    
    NSString *urlString;
    if ([[request.child detailUrl] hasPrefix:@"http"]) {
        urlString = [request.child detailUrl];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@", serverAddress, [request.child detailUrl]];
    }
    NSString *method;
    if ([request.child methodName] == RXRequestMethodGet) {
        method = @"GET";
    } else if ([request.child methodName] == RXRequestMethodPost) {
        method = @"POST";
    }
    
    NSMutableURLRequest *urlRequest = [httpRequestSerializer requestWithMethod:method
                                                                        URLString:urlString
                                                                       parameters:request.requestParams
                                                                            error:NULL];
    /**
    // body:afnetworking自动设置
    if ([request.child methodName] == RXRequestMethodPost) {
        urlRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:request.requestParams options:0 error:NULL];
    }
     */
    
    // 图片上传request
    if ([request.child respondsToSelector:@selector(uploadFormDataBlock)]) {
        urlRequest = [httpRequestSerializer multipartFormRequestWithMethod:method
                                                                      URLString:urlString
                                                                     parameters:request.requestParams
                                                      constructingBodyWithBlock:request.child.uploadFormDataBlock
                                                                          error:NULL];
    }
    
    urlRequest.requestParams = request.requestParams;
    
    return urlRequest;
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(RXBaseRequest *)request
{
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (request.requestSerializerType == RXRequestSerializerTypeHTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == RXRequestSerializerTypeJSON) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    // header
    NSDictionary<NSString *, NSString *> *headerFieldValueDictionary = [request defaultHttpHeaderParams];
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    return requestSerializer;
}

#pragma mark - getters and setters

@end
