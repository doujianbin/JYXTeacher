//
//  JYXHomeLoginSendsmsApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeLoginSendsmsApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 发送验证码：登录获取验证码
 
 @param phone 手机号
 @return JYXHomeLoginSendsmsApi
 */
- (nonnull instancetype)initWithPhone:(nonnull NSString *)phone;

@end
