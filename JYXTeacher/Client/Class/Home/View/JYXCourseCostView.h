//
//  JYXCourseCostView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXCourseCostView : UIView

@property (nonatomic, strong) UILabel *coursePriceTitleLabel;//课程单价
@property (nonatomic, strong) UILabel *coursePriceLabel;
@property (nonatomic, strong) UIImageView *line1;

@property (nonatomic, strong) UILabel *courseHoursTitleLabel;//总课时数
@property (nonatomic, strong) UILabel *courseHoursLabel;
@property (nonatomic, strong) UIImageView *line2;

@property (nonatomic, strong) UILabel *courseAmountTitleLabel;//总金额数
@property (nonatomic, strong) UILabel *courseAmountLabel;
@property (nonatomic, strong) UIImageView *line3;

@property (nonatomic, strong) UILabel *premiumTitleLabel;//保险费用
@property (nonatomic, strong) UIButton *helpImg;
@property (nonatomic, strong) UILabel *premiumLabel;
@property (nonatomic, strong) UIImageView *line4;

@property (nonatomic, strong) UILabel *fundTitleLabel;//公益基金
@property (nonatomic, strong) UIButton *fundImg;
@property (nonatomic, strong) UILabel *fundLabel;
@property (nonatomic, strong) UIImageView *line5;

@property (nonatomic, strong) UILabel *deductionTitleLabel;//平台提成
@property (nonatomic, strong) UILabel *deductionLabel;


- (void)configCourseCostViewWithData:(id)model;
@end
