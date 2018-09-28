//
//  JYXTeachingMethodContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXTeachingMethodContentView : UIView

@property (nonatomic, strong) UIView *teacherVisitBgView;//老师上门
@property (nonatomic, strong) UILabel *teacherVisitTitleLabel;
@property (nonatomic, strong) UISwitch *teacherVisitTitleSwitch;

@property (nonatomic, strong) UIView *studentVisitBgView;//学生上门
@property (nonatomic, strong) UILabel *studentVisitTitleLabel;
@property (nonatomic, strong) UISwitch *studentVisitTitleSwitch;
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *addressRemarkLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIButton *changeAddressBtn;

@property (nonatomic, strong) UIView *otherAddressBgView;//其他地址
@property (nonatomic, strong) UILabel *otherAddressTitleLabel;
@property (nonatomic, strong) UISwitch *otherAddressTitleSwitch;

@property (nonatomic, strong) UIView *shareAddressBgView;//共享地址
@property (nonatomic, strong) UILabel *shareAddressTitleLabel;

@property (nonatomic, strong) UILabel *remarkLabel;//提示
@property (nonatomic, strong) UILabel *addressExplainLabel;//地址说明


- (void)configTeachingMethodViewWithData:(id)model;
@end
