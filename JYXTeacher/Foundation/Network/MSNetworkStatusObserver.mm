//
//  CoreNetWorkStatusObserver.m
//  CoreNetWorkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "MSNetworkStatusObserver.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface MSNetworkStatusObserver ()
/** 2G数组 */
@property (nonatomic,strong) NSArray *technology2GArray;
/** 3G数组 */
@property (nonatomic,strong) NSArray *technology3GArray;
/** 4G数组 */
@property (nonatomic,strong) NSArray *technology4GArray;
/** 网络状态中文数组 */
@property (nonatomic,strong) NSArray *coreNetworkStatusStringArray;
@property (nonatomic,strong) Reachability *reachability;
@property (nonatomic,strong) CTTelephonyNetworkInfo *telephonyNetworkInfo;
@property (nonatomic,copy)   NSString *currentRaioAccess;
/** 是否正在监听 */
@property (nonatomic,assign) BOOL isNoti;
@property (nonatomic,assign) MSCoreNetWorkStatus oldNetworkStatus;
@end

#pragma mark - 初始化
static MSNetworkStatusObserver* MSGlobalCoreStatusInstance = [[MSNetworkStatusObserver alloc] init];

@implementation MSNetworkStatusObserver
+ (instancetype)shareInstance
{
    return MSGlobalCoreStatusInstance;
}

//在 MSNetworkStatusObserver 第一次实例化时初始化该类
+(void)initialize
{
    MSNetworkStatusObserver *status = [MSNetworkStatusObserver shareInstance];
    status.telephonyNetworkInfo =  [[CTTelephonyNetworkInfo alloc] init];
}

/** 获取当前网络状态：枚举 */
+(MSCoreNetWorkStatus)currentNetWorkStatus
{
    MSNetworkStatusObserver *status = [MSNetworkStatusObserver shareInstance];
    return [status statusWithRadioAccessTechnology];
}

/** 获取当前网络状态：字符串 */
+(NSString *)currentNetWorkStatusString
{
    MSNetworkStatusObserver *status = [MSNetworkStatusObserver shareInstance];
    return status.coreNetworkStatusStringArray[[self currentNetWorkStatus]];
}

/** 开始网络监听 */
+(void)beginNotiNetwork:(id<MSCoreStatusProtocol>)listener
{
    MSNetworkStatusObserver *status = [MSNetworkStatusObserver shareInstance];
    
    if(status.isNoti){
        NSLog(@"CoreStatus已经处于监听中，请检查其他页面是否关闭监听！");
        [self endNotiNetwork:(id<MSCoreStatusProtocol>)listener];
    }
    
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:listener
                                             selector:@selector(coreNetworkChangeNoti:)
                                                 name:MSCoreStatusChangedNoti
                                               object:status];
    [[NSNotificationCenter defaultCenter] addObserver:status
                                             selector:@selector(coreNetWorkStatusChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:status
                                             selector:@selector(coreNetWorkStatusChanged:)
                                                 name:CTRadioAccessTechnologyDidChangeNotification
                                               object:nil];
    [status.reachability startNotifier];
    //标记
    status.isNoti = YES;
}

/** 停止网络监听 */
+(void)endNotiNetwork:(id<MSCoreStatusProtocol>)listener
{
    MSNetworkStatusObserver *status = [MSNetworkStatusObserver shareInstance];
    
    if(!status.isNoti){
        NSLog(@"CoreStatus监听已经被关闭");
        return;
    }
    
    //解除监听
    [[NSNotificationCenter defaultCenter] removeObserver:status
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:status
                                                    name:CTRadioAccessTechnologyDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:listener
                                                    name:MSCoreStatusChangedNoti
                                                  object:status];
    //标记
    status.isNoti = NO;
}

/** 是否是Wifi */
+(BOOL)isWifiEnable
{
    return [self currentNetWorkStatus] == CoreNetWorkStatusWifi;
}

/** 是否有网络 */
+(BOOL)isNetworkEnable
{
    MSCoreNetWorkStatus networkStatus = [self currentNetWorkStatus];
    
    return networkStatus != CoreNetWorkStatusUnkhow &&
    networkStatus != CoreNetWorkStatusNone;
}

/** 是否处于高速网络环境：3G、4G、Wifi */
+(BOOL)isHighSpeedNetwork
{
    MSCoreNetWorkStatus networkStatus = [self currentNetWorkStatus];
    
    return  networkStatus == CoreNetWorkStatus3G ||
            networkStatus == CoreNetWorkStatus4G ||
            networkStatus == CoreNetWorkStatusWifi;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        self.oldNetworkStatus = CoreNetWorkStatusUnkhow;
    }
    return self;
}

- (void)coreNetWorkStatusChanged:(NSNotification *)notification
{
    //发送通知
    if (notification.name == CTRadioAccessTechnologyDidChangeNotification &&
        notification.object != nil) {
        self.currentRaioAccess = self.telephonyNetworkInfo.currentRadioAccessTechnology;
    }
    
    MSCoreNetWorkStatus status = [MSNetworkStatusObserver currentNetWorkStatus];
    
    //再次发出通知
    NSDictionary *userInfo = @{@"currentStatusEnum":@(status),
                               @"currentStatusString":[MSNetworkStatusObserver currentNetWorkStatusString],
                               @"oldStatusEnum":@(self.oldNetworkStatus)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MSCoreStatusChangedNoti
                                                        object:self
                                                      userInfo:userInfo];
    self.oldNetworkStatus = status;
}

- (MSCoreNetWorkStatus)statusWithRadioAccessTechnology
{
    MSCoreNetWorkStatus status = (MSCoreNetWorkStatus)[self.reachability currentReachabilityStatus];
    
    NSString *technology = self.currentRaioAccess;
    
    if (status == CoreNetWorkStatusWWAN && technology != nil) {
        if ([self.technology2GArray containsObject:technology]){
            status = CoreNetWorkStatus2G;
        }
        else if ([self.technology3GArray containsObject:technology]){
            status = CoreNetWorkStatus3G;
        }
        else if ([self.technology4GArray containsObject:technology]){
            status = CoreNetWorkStatus4G;
        }
    }
    
    return status;
}

#pragma mark - 属性方法
/** 2G数组 */
-(NSArray *)technology2GArray
{
    @synchronized(_technology2GArray){
        if(_technology2GArray == nil){
            _technology2GArray = @[CTRadioAccessTechnologyEdge,
                                   CTRadioAccessTechnologyGPRS];
        }
    }

    return _technology2GArray;
}

/** 3G数组 */
-(NSArray *)technology3GArray
{
    @synchronized(_technology3GArray){
        if(_technology3GArray == nil){
            _technology3GArray = @[CTRadioAccessTechnologyHSDPA,
                                   CTRadioAccessTechnologyWCDMA,
                                   CTRadioAccessTechnologyHSUPA,
                                   CTRadioAccessTechnologyCDMA1x,
                                   CTRadioAccessTechnologyCDMAEVDORev0,
                                   CTRadioAccessTechnologyCDMAEVDORevA,
                                   CTRadioAccessTechnologyCDMAEVDORevB,
                                   CTRadioAccessTechnologyeHRPD];
        }
    }
    
    return _technology3GArray;
}

/** 4G数组 */
-(NSArray *)technology4GArray
{
    @synchronized(_technology4GArray){
        if(_technology4GArray == nil){
            
            _technology4GArray = @[CTRadioAccessTechnologyLTE];
        }
    }
    
    return _technology4GArray;
}

/** 网络状态中文数组 */
-(NSArray *)coreNetworkStatusStringArray
{
    @synchronized(_coreNetworkStatusStringArray){
        if(_coreNetworkStatusStringArray == nil){
            _coreNetworkStatusStringArray = @[@"无网络",
                                              @"Wifi",
                                              @"蜂窝网络",
                                              @"2G",
                                              @"3G",
                                              @"4G",
                                              @"未知网络"];
        }
    }
    
    return _coreNetworkStatusStringArray;
}
@end
