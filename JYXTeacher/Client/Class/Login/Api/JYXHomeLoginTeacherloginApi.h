//
//  JYXHomeLoginTeacherloginApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeLoginTeacherloginApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 登录
 
 @param phone 手机号
 @param sms 验证码
 @return JYXHomeLoginTeacherloginApi
 */
- (nonnull instancetype)initWithPhone:(nonnull NSString *)phone withSMS:(nonnull NSString *)sms;

@end
