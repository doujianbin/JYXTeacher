//
//  JYXUserManager.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXUserManager.h"

static NSString *const PREFERENCES_KEY_SESSION = @"kUserManager";

@implementation JYXUserManager
+ (JYXUserManager *_Nonnull)shareInstance
{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _user = [[JYXUser alloc] init];
    }
    return self;
}

/**
 *  保存 UserManager 中的信息及当前用户的数据
 */
- (BOOL)save
{
    NSUserDefaults *writer = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_user.userId forKey:@"userId"];
    [writer setValue:[self descriptionWithDictM:dic] forKey:PREFERENCES_KEY_SESSION];
    
    return [_user save];
}

/**
 * 加载保存的 UserManager 信息
 * @return 是否加载成功，如果没有保存过则返回 NO
 */
- (BOOL)load
{
    NSUserDefaults *reader = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [self objectFromJSONString:[reader objectForKey:PREFERENCES_KEY_SESSION]];
    
    if (data) {
        
        NSNumber *userId = [data objectForKey:@"userId"];
        [_user clear];
        [_user load:userId.integerValue];
        
        return YES;
    } else {
        return NO;
    }
}

/**
 *  判断当前是否已经登录
 *
 *  @return 是否已经登录。
 */
- (BOOL)isLogin
{
    return _user.token.isNotBlank;
}

- (void)updateUser
{
    //    YXGGetUserApi *api = [[YXGGetUserApi alloc] init];
    //    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
    //
    //    } failure:^(__kindof RXBaseRequest *request) {
    //
    //    }];
}

#pragma mark - 私有 -
/// 对象转json字符串
- (NSString *)descriptionWithDictM:(NSMutableDictionary *)dictM
{
    NSError *error;
    NSData  *data  = [NSJSONSerialization dataWithJSONObject: dictM
                                                     options: NSJSONWritingPrettyPrinted
                                                       error: &error];
    if (!error){
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return str;
    }
    
    return @"{}";
}

/// json字符串转对象
- (id)objectFromJSONString:(NSString *)jsonString
{
    if (!jsonString) {
        return @{};
    }
    
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                             options:0
                                               error:&error];
    if (!error) {
        return obj;
    }
    return @{};
}

@end
