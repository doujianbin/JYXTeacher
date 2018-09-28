//
//  JYXHomeTeacherWorkListApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherWorkListApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 工作列表

 @param teacherid 用户ID
 @param token 用户token
 @param type 类型1待上课2已上课
 @param startime 上课时间
 @param page 页码
 @param limitnum 页数
 @return JYXHomeTeacherWorkListApi
 */
- (nonnull instancetype)initWithTeacherid:(NSNumber *)teacherid
                                    token:(nonnull NSString *)token
                                     type:(NSNumber *)type
                                 startime:(NSString *)startime
                                     page:(NSNumber *)page
                                 limitnum:(NSNumber *)limitnum;

@end
