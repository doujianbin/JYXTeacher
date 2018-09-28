//
//  JYXHomeTeacherTeachercommentAddApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeTeacherTeachercommentAddApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 老师发表评价

 @param teacherid 教师ID
 @param token 用户token
 @param courseId 课程ID
 @param teachercomment 老师评价
 @param teachercontent 老师评论内容
 @param teacherlabel 老师评论标签
 @return JYXHomeTeacherTeachercommentAddApi
 */
- (nonnull instancetype)initWithTeacherid:(NSNumber *)teacherid token:(NSString *)token courseId:(NSNumber *)courseId teachercomment:(NSString *)teachercomment teachercontent:(NSString *)teachercontent teacherlabel:(NSString *)teacherlabel;

@end
