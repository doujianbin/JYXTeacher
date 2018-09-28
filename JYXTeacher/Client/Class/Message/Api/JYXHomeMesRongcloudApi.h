//
//  JYXHomeMesRongcloudApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeMesRongcloudApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>
/**
 获取融云用户token

 @param userid 用户ID
 @param username 用户名称
 @param type 类型 1为查询token 2为获取签名 3为匹配签名
 @return JYXHomeMesRongcloudApi
 */
- (nonnull instancetype)initWithUserId:(nonnull NSNumber *)userid username:(NSString *)username type:(NSNumber *)type;

@end
