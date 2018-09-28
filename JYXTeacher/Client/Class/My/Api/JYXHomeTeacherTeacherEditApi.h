//
//  JYXHomeTeacherTeacherEditApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/26.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeacherEditApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>


/**
 修改个人信息
 
 @param userid 用户ID
 @param token 用户token
 @param nick 用户昵称
 @param cardname 真实姓名
 @param sex 性别
 @return JYXHomeTeacherTeacherEditApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                  nick:(NSString *)nick
                                   sex:(NSString *)sex;

/**
 修改预设价格

 @param userid 用户ID
 @param token 用户token
 @param cardname 真实姓名
 @param citypriceone 一年级预设价格
 @param citypricetwo 二年级预设价格
 @param citypricethree 三年级预设价格
 @param citypricefour 四年级预设价格
 @param citypricefive 五年级预设价格
 @param citypricesix 六年级预设价格
 @param citypriceseven 初一预设价格
 @param citypriceeight 初二预设价格
 @param citypricenine 初三预设价格
 @param citypriceten 高一预设价格
 @param citypriceeleven 高二预设价格
 @param citypricetwelve 高三预设价格
 @return JYXHomeTeacherTeacherEditApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                          citypriceone:(NSString *)citypriceone
                          citypricetwo:(NSString *)citypricetwo
                        citypricethree:(NSString *)citypricethree
                         citypricefour:(NSString *)citypricefour
                         citypricefive:(NSString *)citypricefive
                          citypricesix:(NSString *)citypricesix
                        citypriceseven:(NSString *)citypriceseven
                        citypriceeight:(NSString *)citypriceeight
                         citypricenine:(NSString *)citypricenine
                          citypriceten:(NSString *)citypriceten
                       citypriceeleven:(NSString *)citypriceeleven
                       citypricetwelve:(NSString *)citypricetwelve;

/**
 认证基本信息

 @param userid 用户ID
 @param token 用户token
 @param cardname 真实姓名
 @param sex 性别
 @param education 学历
 @param worktime 从业时间
 @param unit 所属单位
 @param unittype 单位类型
 @param unitlook 是否显示单位全称 0不可见1可见
 @param oneselfinfo 自我介绍
 @return JYXHomeTeacherTeacherEditApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                   sex:(NSString *)sex
                             education:(NSString *)education
                              worktime:(NSString *)worktime
                                  unit:(NSString *)unit
                              unittype:(NSString *)unittype
                              unitlook:(NSNumber *)unitlook
                           oneselfinfo:(NSString *)oneselfinfo;

/**
 修改教师类型

 @param userid 用户ID
 @param token 用户token
 @param cardname 真实姓名
 @param teachertype 教师类型
 @return JYXHomeTeacherTeacherEditApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                           teachertype:(NSString *)teachertype;

/**
 修改教师信息
 
 @param userid 用户ID
 @param token 用户token
 @param cardname 真实姓名
 @param head 头像
 @return JYXHomeTeacherTeacherEditApi
 */
- (nonnull instancetype)initWithUserid:(NSString *)userid
                                 token:(NSString *)token
                              cardname:(NSString *)cardname
                                  head:(NSString *)head;

@end
