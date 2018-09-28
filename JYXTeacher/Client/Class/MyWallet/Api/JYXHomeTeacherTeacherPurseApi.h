//
//  JYXHomeTeacherTeacherPurseApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeacherPurseApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 教师钱包余额接口
 
 @param userid 用户ID
 @param token 用户token
 @return JYXHomeTeacherTeacherPurseApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token;

@end
