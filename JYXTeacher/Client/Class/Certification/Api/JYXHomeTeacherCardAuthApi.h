//
//  JYXHomeTeacherCardAuthApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherCardAuthApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 身份认证接口
 
 @param userid 用户ID
 @param token 用户token
 @param pic 图片
 @return JYXHomeTeacherCardAuthApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token pic:(NSString *)pic;


@end
