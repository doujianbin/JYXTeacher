//
//  JYXHomeTeacherSearchInfoApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSearchInfoApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 课程明细

 @param userid 用户ID
 @param token 用户token
 @param courseId 课程ID
 @param type 课程类型1.课程2.抢单
 @return JYXHomeTeacherSearchInfoApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token courseId:(NSNumber *)courseId type:(NSNumber *)type;

@end
