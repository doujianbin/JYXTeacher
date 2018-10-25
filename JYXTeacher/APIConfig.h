//
//  APIConfig.h
//  DocChat
//
//  Created by SeanLiu on 15/8/4.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#ifndef DocChat_APIConfig_h
#define DocChat_APIConfig_h
/*
 http://47.97.174.40:9001
 http://47.97.174.40:9000
 */

//1:正式网 2:测试打包
#define SERVER_TYPE 2

#if (SERVER_TYPE == 1)
//appstore环境
#define API_Login                   @"http://www.jiaoyuxuevip.com/"
#define KEY_JPUSH                   @"9ce67bdc962baa16d9abb8c8"
#define Jpush                       @"YES"
#define SERVER_HOST                 @"47.97.174.40:9001"

#elif (SERVER_TYPE == 2)
//测试打包
#define API_Login                   @"http://www.jiaoyuxuevip.com/"
#define KEY_JPUSH                   @"9ce67bdc962baa16d9abb8c8"
#define Jpush                       @"NO"
#define SERVER_HOST                 @"47.97.174.40:9001"
#endif

//http://www.jiaoyuxuevip.com/
//http://10.2.4.130/

//HTTP_PROTOCOL 用来区分 http与https
//#define HTTPS_PROTOCOL
#if (SERVER_TYPE == 2)
#define SERVER_PROTOCOL @"http://"
#else
#define SERVER_PROTOCOL @"https://"
#endif
#define SERVER_HOST                 @"47.97.174.40:9001"
//JPUSH
#define JPushAppKey @"9ce67bdc962baa16d9abb8c8"

//API VERSION
#define API_VERSION @""
//登录
#define IsLogin       @"IsLogin"
//手机号
#define TeacherPhone  @"TeacherPhone"
//本账号融云的id
#define RongCould @""
//头像前缀
#define HeadQZ @"https://gouku-ware.oss-cn-zhangjiakou.aliyuncs.com/"
//推送注册id
#define Registionid @"registionid"

//上传图片
#define API_POST_uploadPic @"/common/upload"

#define IsLookDaoHang       @"LookDaoHang"   //是否显示导航页

//上传版本号
#define BasicSystem @"home/basic/system"


/*
 接单设置API
 */
//教师待上课列表
#define API_POST_TeacherWorkList @"home/teacher/work_list"

//获取教师信息
#define API_POST_logiNTeacherinfo @"home/login/teacherinfo"

//获取教师授课时间
#define API_POST_TeacherLessonTime @"home/teacher/lesson_time"

//接单设置  提交授课年级科目
#define API_POST_TeacherLessonClass @"home/teacher/set_up"

//教师添加评价
#define API_POST_TeacherAddReview @"home/teacher/teachercomment_add"

//教师举报
#define API_POST_TeacherReport @"home/basic/tip"

//教师课时费
#define API_POST_TeacherClassMoney @"home/teacher/lesson_money"

//教师账户管理
#define API_POST_TeachePpaynumber @"home/basic/paynumber"

//教师提现
#define API_POST_TeacherCash @"home/basic/cash"

//教师缴纳罚款
#define API_POST_Teacherpayfor @"home/pay/teacherpayfor"

//教师查询钱包余额
#define API_POST_TeacherPurse @"home/teacher/teacher_purse"

//教师认证状态查询
#define API_POST_TeacherBaseinfo @"home/teacher/teacher_baseinfo"

//教师上传资料
#define API_POST_TeacherEdit @"home/teacher/teacher_edit"

//获取虚拟电话
#define API_POST_SelectPhoneNum @"/home/phone/acon"

//上传registratid
#define API_POST_GetRegistration @"home/base/getregistration_id"

//问题反馈列表
#define API_POST_Feedbackquestion @"home/basic/feedbackquestion"

//提交问题反馈
#define API_POST_Postfeedback @"home/basic/feedback"

//获取用户分享列表数据
#define API_POST_Sharelist @"home/basic/sharelist"

#endif
