//
//  RTHttpClient.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-10.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "RTHttpClient.h"
#import "RTJSONResponseSerializerWithData.h"
#import <AFNetworking/AFNetworking.h>
//#import <Reachability/Reachability.h>
#import "Reachability.h"
#import <netinet/in.h>
#import <AdSupport/AdSupport.h>
#import "AppUtils.h"
#import "GetUUID.h"
#import "MBProgressHUD+JDragon.h"
//#import "LoginStorage.h"

#define JSONResponseSerializerWithDataKey @"JSONResponseSerializerWithDataKey"

@interface RTHttpClient()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation RTHttpClient

- (id)init{
    if (self = [super init]){
        self.manager = [AFHTTPSessionManager manager];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        [securityPolicy setAllowInvalidCertificates:YES];
        
        self.manager.securityPolicy = securityPolicy;
        
        //请求参数序列化类型
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应结果序列化类型
        self.manager.responseSerializer = [RTJSONResponseSerializerWithData serializer];
        
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 20;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return self;
}

+ (RTHttpClient *)defaultClient
{
    static RTHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                prepare:(PrepareBlock)prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //请求的URL
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    //    NSString *idfa = [GetUUID getUUID];
    //    [self.manager.requestSerializer setValue:idfa forHTTPHeaderField:@"Gouku-Device-Id"];
    //    NSString *version = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //
    //    //商家端
    //    [self.manager.requestSerializer setValue:@"12" forHTTPHeaderField:@"Gouku-App-Origin"
    //     ];
    //
    //    [self.manager.requestSerializer setValue:version forHTTPHeaderField:@"x-docchat-app-version"];
    //    //手机系统版本
    //    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //    [self.manager.requestSerializer setValue:phoneVersion forHTTPHeaderField:@"Gouku-Device-Version"];
    //
    //    [self.manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Gouku-OS-Version"];
    //     self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    self.manager.requestSerializer.timeoutInterval = 20;
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    if (user.userId != nil) {
        [self.manager.requestSerializer setValue:user.token forHTTPHeaderField:@"token"];
    }
    //    //预处理
    if (prepare) {
        prepare();
    }
    
    
    //拦截failure 添加登录失效4002的处理
    void (^tFailure)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        
        id json = error.userInfo[JSONResponseSerializerWithDataKey];
        if (!json) {
            failure(task,error);
            return;
        }
        
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        id json_object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        if ([json_object isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic_json = (NSDictionary*)json_object;
            if (dic_json.count) {
                if ([dic_json objectForKey:@"code"]) {
                    NSInteger code = [[dic_json objectForKey:@"code"] integerValue];
                    if (code == 4002) {
                        return;
                    }
                }
            }
        }
        
        failure(task,error);
    };
    
    if ([AppUtils isConnectionAvailable]) {
        switch (method) {
            case RTHttpRequestGet:
            {
                [self.manager GET:url parameters:parameters success:success failure:tFailure];
            }
                break;
            case RTHttpRequestPost:
            {
                [self.manager POST:url parameters:parameters success:success failure:tFailure];
            }
                break;
            case RTHttpRequestDelete:
            {
                [self.manager DELETE:url parameters:parameters success:success failure:tFailure];
            }
                break;
            case RTHttpRequestPut:
            {
                [self.manager PUT:url parameters:parameters success:success failure:tFailure];
            }
                break;
            default:
                break;
        }
    }else{
        //发出网络异常通知广播
        [MBProgressHUD hideHUD];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
        
    }
}

- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([AppUtils isConnectionAvailable]) {
        [self.manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
}

- (void)cancelRequest
{
    [_manager.operationQueue cancelAllOperations];
}

@end

