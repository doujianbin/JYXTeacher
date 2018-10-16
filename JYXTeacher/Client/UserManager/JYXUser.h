//
//  JYXUser.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYXUser : NSObject
//用户token
@property (nonatomic, copy) NSString *token;
//用户ID(字段名id)
@property (nonatomic, copy) NSString *userId;
//城市ID
@property (nonatomic, copy) NSString *cityId;
//用户头像
@property (nonatomic, copy) NSString *avatar;
//教师电话
@property (nonatomic, copy) NSString *phone;
//身份证姓名
@property (nonatomic, copy) NSString *cardname;
//性别
@property (nonatomic, copy) NSString *sex;
//昵称
@property (nonatomic, copy) NSString *nickname;
//teacherID
@property (nonatomic, copy) NSString *teacherId;
//信用
@property (nonatomic, copy) NSString *credit;
//教师地址
@property (nonatomic, copy) NSString *addr;
//教师类型
@property (nonatomic, copy) NSString *teachertype;
//可接受最远距离
@property (nonatomic, strong) NSNumber *range;
//接受教师上门0否1是
@property (nonatomic, strong) NSNumber *teachertohome;
//接受学生上门0否1是
@property (nonatomic, strong) NSNumber *studenttohome;
//是否接受其他地址
@property (nonatomic, strong) NSNumber *otheraddr;
//是否接受共享地址
@property (nonatomic, strong) NSNumber *shareaddr;
//是否推送0否1是
@property (nonatomic, strong) NSNumber *ispush;
//是否进行接单设置  （只要不为0就是进行了接单设置）
@property (nonatomic, strong) NSNumber *planhour;
//教师课程
@property (nonatomic, strong) NSArray  *gradesubject;
//身份验证状态0未认证1认证中2已通过3未通过
@property (nonatomic, strong) NSNumber *cardstatu;
//学历认证状态0未认证1认证中2已通过3未通过
@property (nonatomic, strong) NSNumber *educationstatu;
//教师资格认证状态0未认证1认证中2已通过3未通过
@property (nonatomic, strong) NSNumber *senioritystatu;
//学历
@property (nonatomic, copy) NSString *education;
//从业时间（时间戳）
@property (nonatomic, copy) NSString *worktime;
//所属单位
@property (nonatomic, copy) NSString *unit;
//单位是否可见
@property (nonatomic, strong) NSNumber *unitlook;
//自我介绍
@property (nonatomic, copy) NSString *oneselfinfo;
//单位类型
@property (nonatomic, copy) NSString *unittype;

//年级一指导价
@property (nonatomic, copy) NSString *citypriceone;
//年级二指导价
@property (nonatomic, copy) NSString *citypricetwo;
//年级三指导价
@property (nonatomic, copy) NSString *citypricethree;
//年级四指导价
@property (nonatomic, copy) NSString *citypricefour;
//年级五指导价
@property (nonatomic, copy) NSString *citypricefive;
//年级六指导价
@property (nonatomic, copy) NSString *citypricesix;
//初一指导价
@property (nonatomic, copy) NSString *citypriceseven;
//初二指导价
@property (nonatomic, copy) NSString *citypriceeight;
//初三指导价
@property (nonatomic, copy) NSString *citypricenine;
//高一指导价
@property (nonatomic, copy) NSString *citypriceten;
//高二指导价
@property (nonatomic, copy) NSString *citypriceeleven;
//高三指导价
@property (nonatomic, copy) NSString *citypricetwelve;

/** 获取用户文件缓存根目录，全路径，结尾含分隔符。*/
@property (nonatomic, copy, readonly) NSString *cacheRootDirectory;

- (void)configUserData:(NSDictionary *)dict;
/**
 *  保存当前用户的数据
 */
- (BOOL)save;
/**
 *  清除用户信息
 */
- (void)clear;
/**
 * 加载用户数据到当前对象，如果加载失败则不改变当前 User 的内容
 * @param userId 用户 id
 * @return 是否加载成功，如果没有保存过则返回 NO
 */
-(BOOL)load:(int64_t)userId;
@end
