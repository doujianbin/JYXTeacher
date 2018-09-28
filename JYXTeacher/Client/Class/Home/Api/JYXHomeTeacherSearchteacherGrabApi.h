//
//  JYXHomeTeacherSearchteacherGrabApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSearchteacherGrabApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 抢单
 
 @param userid 用户ID
 @param token 用户token
 @param courseId 课程ID
 @return JYXHomeTeacherSearchInfoApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token courseId:(NSString *)courseId;

@end
