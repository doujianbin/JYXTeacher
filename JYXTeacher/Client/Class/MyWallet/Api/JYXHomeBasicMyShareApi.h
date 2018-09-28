//
//  JYXHomeBasicMyShareApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeBasicMyShareApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 我的共享收益
 
 @param userid 用户ID
 @param token 用户token
 @return JYXHomeBasicMyShareApi
 */
- (nonnull instancetype)initWithUserid:(nonnull NSString *)userid WithToken:(nonnull NSString *)token;

@end
