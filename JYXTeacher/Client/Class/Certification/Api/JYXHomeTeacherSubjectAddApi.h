//
//  JYXHomeTeacherSubjectAddApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSubjectAddApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 添加专业认证接口
 
 @param userid 用户ID
 @param token 用户token
 @param subjectid 专业ID
 @param subjectname 专业名称
 @param pic 图片
 @return JYXHomeTeacherSubjectAddApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token subjectid:(NSString *)subjectid subjectname:(NSString *)subjectname pic:(NSString *)pic;

@end
