//
//  JYXCourseDetailBottomBarView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXCourseDetailBottomBarView : UIView

@property (nonatomic, strong) UIButton *previewHomeworkBtn;//预习作业
@property (nonatomic, strong) UIButton *courseFinishBtn;//完成
@property (nonatomic, strong) UIButton *communicateBtn;//沟通

@property (nonatomic, strong) UIButton *afterHomeworkBtn;//课后作业
@property (nonatomic, strong) UIButton *appraiseBtn;//去评价
@property (nonatomic, strong) UIButton *communicateBtn1;//沟通
@property (nonatomic, strong) UIButton *reportBtn;//举报

@property (nonatomic, strong) UIButton *takeOrderBtn;//抢单


- (void)configCourseDetailBottomBarViewWithData:(int)model;
@end
