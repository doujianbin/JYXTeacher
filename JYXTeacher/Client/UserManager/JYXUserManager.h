//
//  JYXUserManager.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYXUser.h"

@interface JYXUserManager : NSObject
/** 当前登录的用户的信息，如果未登录则 user 内的信息无意并且不确定 */
@property (atomic, strong, readonly, nonnull) JYXUser *user;

+ (JYXUserManager *_Nonnull)shareInstance;

/**
 *  保存 UserManager 中的信息及当前用户的数据
 */
- (BOOL)save;

/**
 * 加载保存的 UserManager 信息
 * @return 是否加载成功，如果没有保存过则返回 NO
 */
- (BOOL)load;

/**
 *  判断当前是否已经登录
 *
 *  @return 是否已经登录。
 */
- (BOOL)isLogin;

/**
 *  更新用户信息
 */
- (void)updateUser;

@end
