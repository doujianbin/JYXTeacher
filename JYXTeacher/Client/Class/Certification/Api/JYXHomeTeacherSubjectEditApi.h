//
//  JYXHomeTeacherSubjectEditApi.h
//  JYXTeacher
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSubjectEditApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 修改专业认证接口
 
 @param userid 用户ID
 @param token 用户token
 @param subjectid 专业ID
 @param subjectname 专业名称
 @param pic 图片
 @param keyword 科目关键字
 @return JYXHomeTeacherSubjectEditApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token subjectid:(NSString *)subjectid subjectname:(NSString *)subjectname pic:(NSString *)pic keyword:(NSString *)keyword;

@end
