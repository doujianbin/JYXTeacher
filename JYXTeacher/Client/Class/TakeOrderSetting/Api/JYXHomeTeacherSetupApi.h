//
//  JYXHomeTeacherSetupApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherSetupApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 接单设置接口

 @param teacherid 教师ID
 @param onr 年级-学科json
 @param token 令牌
 @param grade 年级
 @param subject 学科
 @param longitude 经度
 @param lat 纬度
 @param range 距离
 @param addr 地址
 @param teachertohome 是否接受教师上门
 @param studenttohome 是否接受学生上门
 @param otheraddr 是否接受其他地址
 @param shareaddr 是否接受共享地址
 @param addrlabel 地址标注
 @param times 时间组
 @return JYXHomeTeacherSetupApi
 */
- (nonnull instancetype)initWithTeacherid:(nonnull NSNumber *)teacherid
                                      onr:(nonnull NSString *)onr
                                    token:(nonnull NSString *)token
                                    grade:(nonnull NSString *)grade
                                  subject:(nonnull NSString *)subject
                                longitude:(NSString *)longitude
                                      lat:(NSString *)lat
                                    range:(NSString *)range
                                     addr:(NSString *)addr
                            teachertohome:(NSNumber *)teachertohome
                            studenttohome:(NSNumber *)studenttohome
                                otheraddr:(NSNumber *)otheraddr
                                shareaddr:(NSNumber *)shareaddr
                                addrlabel:(NSString *)addrlabel
                                    times:(NSString *)times;

@end
