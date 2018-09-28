//
//  JYXHomeTeacherSeniorityAuthApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSeniorityAuthApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 资质认证接口
 
 @param userid 用户ID
 @param token 用户token
 @param pic 图片
 @return JYXHomeTeacherSeniorityAuthApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token pic:(NSString *)pic;


@end
