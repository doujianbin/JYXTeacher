//
//  JYXHomeTeacherTeacherRankingApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeacherRankingApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 教师排名
 
 @param teacherid 教师ID
 @param token 用户token
 @param page 当前页
 @param limitnum 每页数量
 @param cityid 城市ID
 @return JYXHomeTeacherMyStudentApi
 */
- (nonnull instancetype)initWithTeacherid:(NSString *)teacherid token:(NSString *)token page:(NSString *)page limitnum:(NSString *)limitnum cityid:(NSNumber *)cityid;

@end
