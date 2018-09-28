//
//  JYXHomeGetTeacherInfoApi.h
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/11.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeGetTeacherInfoApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 获取教师信息接口
 
 @param userid 用户ID
 @param token 用户token
 @return JYXHomeGetTeacherInfoApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token;

@end
