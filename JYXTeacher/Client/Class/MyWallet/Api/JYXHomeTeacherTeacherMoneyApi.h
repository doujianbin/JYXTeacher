//
//  JYXHomeTeacherTeacherMoneyApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeacherMoneyApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 教师课时费
 
 @param userid 用户ID
 @param token 用户token
 @return JYXHomeTeacherTeacherMoneyApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token;

@end
