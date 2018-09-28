//
//  TeacherInfoEntity.h
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/18.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "BaseEntity.h"

@interface TeacherInfoEntity : BaseEntity

@property (nonatomic ,strong) NSString  *nick;         //教师昵称
@property (nonatomic ,strong) NSString  *teachertype;  //教师类型 全职教师/自由教师/大学生
@property (nonatomic ,strong) NSString  *cardname;     //教师姓名
@property (nonatomic ,strong) NSString  *sex;          //教师性别
@property (nonatomic ,strong) NSString  *education;    //教师学历
@property (nonatomic ,strong) NSString  *worktime;     //教师从教时间
@property (nonatomic ,strong) NSString  *unit;         //教师单位名称
@property (nonatomic ,strong) NSString  *unittype;      //教师单位类型
@property (nonatomic ,assign) int        unitlook;      //教师单位匿名 传数字：0不可见1可见
@property (nonatomic ,strong) NSString  *oneselfinfo;   //自我介绍

@end
