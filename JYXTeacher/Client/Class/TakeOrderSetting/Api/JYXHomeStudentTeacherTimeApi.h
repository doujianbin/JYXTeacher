//
//  JYXHomeStudentTeacherTimeApi.h
//  JYXTeacher
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeStudentTeacherTimeApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 教师日程查询

 @param userid 用户ID
 @param token 用户token
 @param teacherid 教师ID
 @param time 时间
 @return JYXHomeStudentTeacherTimeApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                    token:(NSString *)token
                                teacherid:(NSString *)teacherid
                                     time:(NSString *)time;

@end
