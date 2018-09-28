//
//  BaseHandler.m
//  zlydoc-iphone
//
//  Created by Ryan on 14-6-25.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseHandler.h"
#import "APIConfig.h"
#import "UserDefaultsUtils.h"
#import "BaseEntity.h"
#import "AppUtils.h"
#import "NSString+URLEncoding.h"
//#import "LoginViewController.h"

@implementation BaseHandler

+ (NSString *)requestUrlWithPath:(NSString *)path
{
    NSString * pathEncoding = [path stringByURLEncoding];
    NSString *serverHost = SERVER_HOST;
    NSString *serverPath = [[SERVER_PROTOCOL stringByAppendingString:[serverHost stringByAppendingString:API_VERSION]] stringByAppendingString:pathEncoding];
    
    return serverPath;
}


+ (NSString *)requestUrlWithHttpsPath:(NSString *)path
{
    NSString *serverHost = SERVER_HOST;

    NSString *serverPath = [[SERVER_PROTOCOL stringByAppendingString:[serverHost stringByAppendingString:API_VERSION]] stringByAppendingString:path];
    return [serverPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)requestNoVersionNumUrlWithHttpsPath:(NSString *)path
{
    NSString *serverHost = SERVER_HOST;
    return [SERVER_PROTOCOL stringByAppendingString:[serverHost stringByAppendingString:path]];
}


+ (NSString *)requestDocumentsWithHttpsPath:(NSString *)path
{
    NSString *serverHost = @"app.zlycare.com";
    return [SERVER_PROTOCOL stringByAppendingString:[serverHost stringByAppendingString:path]];
}

+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error complete:(FailedBlock)failed
{
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//    DLog(@"%@",error.description);
//    NSInteger statusCode = response.statusCode;
    id json = error.userInfo[JSONResponseSerializerWithDataKey];
    if(!json){
        if (failed) {
            failed(404,@"数据获取失败");
        }
        return;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (failed) {
        if([NSJSONSerialization isValidJSONObject:dic_json])
        {
//            BaseEntity *result = [BaseEntity parseObjectWithKeyValues:dic_json];
//            if (result.errCode == 9) {
//                [LoginStorage saveIsLogin:NO];
//                LoginViewController *vc = [[LoginViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//            }else{
//                failed(result.errCode,result.errMessage);
//            }
        }else{
            failed(404,@"数据获取失败");
        }
    }
}

+ (NSInteger)statusCodeWithTask:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    return statusCode;
}



@end
