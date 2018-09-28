//
//  JYXHomeTeacherSubjectListApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSubjectListApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 专业认证列表接口
 
 @param userid 用户ID
 @param token 用户token
 @return JYXHomeTeacherSubjectListApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token;

@end
