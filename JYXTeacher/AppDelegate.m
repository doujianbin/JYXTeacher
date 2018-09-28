//
//  AppDelegate.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "AppDelegate.h"
#import "JYXApplicationHandler.h"
#import "WXApi.h"
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>
#import <AlipaySDK/AlipaySDK.h>
#import <UMShare/UMSocialManager.h>
#import <UMCommon/UMConfigure.h>
#import <AlipaySDK/AlipaySDK.h>
#import "JYXHomeMesRongcloudApi.h"
#import <AVFoundation/AVFoundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <IQKeyboardManager.h>
#import "MyHandler.h"

@interface AppDelegate ()<RCIMUserInfoDataSource,WXApiDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window makeKeyAndVisible];
    
    self.window = [JYXApplicationHandler shareInstance].window;
    
    [UMConfigure initWithAppkey:@"5b9f2586b27b0a4f5f0000c8" channel:@"App Store"];
    
    [self configUSharePlatforms];
    
    BOOL isFinish = [[JYXApplicationHandler shareInstance] application:application
                                         didFinishLaunchingWithOptions:launchOptions];
    
    //    //极光推送
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    BOOL isProduction;
    if ([Jpush isEqualToString:@"YES"]) {
        isProduction = YES;
    }else{
        isProduction = NO;
    }
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            
            //上传注册id
            [[NSUserDefaults standardUserDefaults] setValue:registrationID forKey:Registionid];
        }
        else{
            //            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    [AMapServices sharedServices].apiKey = @"642c4c0ef4c2fb53f373f09d7bf64bb6";
    [WXApi registerApp:@"wxad796f19bfe091d0"];
    
    [self loginRongYun];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    return isFinish;
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxad796f19bfe091d0" appSecret:@"576624a91e77e8e336eb069050d2e9f0" redirectURL:nil];
//
//    /* 设置分享到QQ互联的appID
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     100424468.no permission of union id
//     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
//     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107806404"/*设置QQ平台的appID*/  appSecret:@"jP7tQtCxq7ccATZB" redirectURL:@"http://mobile.umeng.com/social"];
}


- (void)loginRongYun
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeMesRongcloudApi *api = [[JYXHomeMesRongcloudApi alloc] initWithUserId:@(user.teacherId.integerValue) username:user.nickname type:@1];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [[RCIM sharedRCIM] connectWithToken:dict[@"token"]  success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
    
}
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    

    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //程序在前台
        //        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cashcomplete" object:nil userInfo:nil];
    }
    else {
        // 程序打开走这里拿到通知信息
        //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//点击消息进入

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cashcomplete" object:nil userInfo:nil];
    }
    else {
        // 判断为本地通知
        //       NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler();  // 系统要求执行这个方法
}

#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    
    NSString *content = [userInfo valueForKey:@"content"];
    
    NSDictionary *dic =  [self dictionaryWithJsonString:content];
    
    //    NSLog(@"dic = %@",dic);
  
    
}
//#endif

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NF_ALIPAY_PAY_SUCCESS object:nil];
//                    [MBProgressHUD showSuccessMessage:@"支付成功"];
                }else{
                    [MBProgressHUD showInfoMessage:[resultDic objectForKey:@"memo"]];
                }
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"网页1result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        } else {
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
        if ([url.host isEqualToString:@"safepay"]) {
            
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NF_ALIPAY_PAY_SUCCESS object:nil];
//                    [MBProgressHUD showSuccessMessage:@"支付成功"];
                }
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
        
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"网页2result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
            
        } else {
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return YES;
}

- (void) onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp *)resp;
        [MBProgressHUD hideHUD];
        switch (response.errCode)
        {
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NF_WECHAT_PAY_SUCCESS object:nil];
            }
                break;
                
            case WXErrCodeUserCancel:
            {
                [MBProgressHUD showErrorMessage:@"支付取消"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:NF_WECHAT_PAY_USER_CANCEL object:nil];
            }
                break;
                
            default:
            {
                [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"支付失败，retcode=%d", resp.errCode]];
            }
                break;
        }
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
            {
                //                [[NSNotificationCenter defaultCenter] postNotificationName:NF_WECHAT_SHARE_DYNAMIC_SUCCESS object:nil];
            }
                break;
                
            case WXErrCodeUserCancel:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}


- (void)managerDidRecvPaymentResponse:(PayResp *)response {
    switch (response.errCode) {
        case WXSuccess:
            //            [self.v_cashComplete setHidden:NO];
            break;
        case WXErrCodeUserCancel:
            [MBProgressHUD showInfoMessage:@"中途取消"];
            break;
        default:{
            [MBProgressHUD showInfoMessage:@"支付失败"];
        }
            break;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //与融云断开连接
    [[RCIM sharedRCIM] disconnect];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    RCUserInfo * info = [[RCUserInfo alloc] init];

    [MyHandler selectRCIMInformationWithUserId:userId prepare:^{

    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        info.name = dic[@"nick"];
        info.portraitUri = [NSString stringWithFormat:@"http://www.jiaoyuxuevip.com/%@", dic[@"head"]];
//        info.userId = [userId substringFromIndex:1];
        completion(info);
    } failed:^(NSInteger statusCode, id json) {

    }];
}

@end
