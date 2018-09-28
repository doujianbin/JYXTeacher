//
//  JYXHomeTeacherTeacherClassesApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeacherClassesApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 课程表

 @param teacherid 用户ID
 @param token 用户token
 @param year 年（时间戳）
 @param mouth 月（时间戳）
 @param page 页码
 @param limitnum 每页数量
 @return JYXHomeTeacherTeacherClassesApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)teacherid WithToken:(nonnull NSString *)token year:(NSString *)year mouth:(NSString *)mouth page:(NSNumber *)page limitnum:(NSNumber *)limitnum;

@end
