//
//  JYXCourseDetailBottomBarView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseDetailBottomBarView.h"
@interface JYXCourseDetailBottomBarView ()
//@property (nonatomic, strong) UIButton *previewHomeworkBtn;//预习作业
//@property (nonatomic, strong) UIButton *courseFinishBtn;//完成
//@property (nonatomic, strong) UIButton *communicateBtn;//沟通
//
//@property (nonatomic, strong) UIButton *afterHomeworkBtn;//课后作业
//@property (nonatomic, strong) UIButton *appraiseBtn;//去评价
//@property (nonatomic, strong) UIButton *communicateBtn1;//沟通
//
//@property (nonatomic, strong) UIButton *takeOrderBtn;//抢单
@end

@implementation JYXCourseDetailBottomBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.previewHomeworkBtn];
    [self.previewHomeworkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.width.mas_equalTo((SCREEN_WIDTH - 14 - 4) / 3);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.courseFinishBtn];
    [self.courseFinishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.previewHomeworkBtn.mas_right).offset(2);
        make.top.width.height.equalTo(self.previewHomeworkBtn);
    }];
    
    [self addSubview:self.communicateBtn];
    [self.communicateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.courseFinishBtn.mas_right).offset(2);
        make.top.width.height.equalTo(self.previewHomeworkBtn);
    }];
    
    [self addSubview:self.afterHomeworkBtn];
    [self.afterHomeworkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.appraiseBtn];
    [self.appraiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.afterHomeworkBtn.mas_right).offset(2);
        make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.communicateBtn1];
    [self.communicateBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appraiseBtn.mas_right).offset(2);
        make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.communicateBtn1.mas_right).offset(2);
        make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.takeOrderBtn];
    [self.takeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-7);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(43);
    }];
}

- (void)configCourseDetailBottomBarViewWithData:(int)model
{
    
    if (model == 1) {
        self.previewHomeworkBtn.hidden = NO;
        self.courseFinishBtn.hidden = NO;
        self.communicateBtn.hidden = NO;
        
        self.afterHomeworkBtn.hidden = YES;
        self.appraiseBtn.hidden = YES;
        self.communicateBtn1.hidden = YES;
        self.reportBtn.hidden = YES;
        
        self.takeOrderBtn.hidden = YES;
        
        [self.previewHomeworkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(7);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 4) / 3);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.courseFinishBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.previewHomeworkBtn.mas_right).offset(2);
            make.top.width.height.equalTo(self.previewHomeworkBtn);
        }];
        
        [self.communicateBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.courseFinishBtn.mas_right).offset(2);
            make.top.width.height.equalTo(self.previewHomeworkBtn);
        }];
        
    }else if (model == 2){
        self.previewHomeworkBtn.hidden = YES;
        self.courseFinishBtn.hidden = YES;
        self.communicateBtn.hidden = YES;
        
        self.afterHomeworkBtn.hidden = NO;
        self.appraiseBtn.hidden = NO;
        self.communicateBtn1.hidden = NO;
        self.reportBtn.hidden = NO;
        
        self.takeOrderBtn.hidden = YES;
        
        [self.afterHomeworkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(7);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.appraiseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.afterHomeworkBtn.mas_right).offset(2);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.communicateBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.appraiseBtn.mas_right).offset(2);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.reportBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.communicateBtn1.mas_right).offset(2);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 6) / 4);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
    }else if (model == 3){
        self.previewHomeworkBtn.hidden = YES;
        self.courseFinishBtn.hidden = YES;
        self.communicateBtn.hidden = YES;
        
        self.afterHomeworkBtn.hidden = YES;
        self.appraiseBtn.hidden = YES;
        self.communicateBtn1.hidden = YES;
        self.reportBtn.hidden = YES;
        
        self.takeOrderBtn.hidden = NO;
        
        [self.takeOrderBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 7 - 115);
            make.width.mas_equalTo(115);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(20);
        }];
    }else{
        self.previewHomeworkBtn.hidden = YES;
        self.courseFinishBtn.hidden = YES;
        self.communicateBtn.hidden = YES;
        
        self.afterHomeworkBtn.hidden = NO;
        self.appraiseBtn.hidden = YES;
        self.communicateBtn1.hidden = NO;
        self.reportBtn.hidden = NO;
        
        self.takeOrderBtn.hidden = YES;
        
        [self.afterHomeworkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(7);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 4) / 3);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.communicateBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.afterHomeworkBtn.mas_right).offset(2);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 4) / 3);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
        
        [self.reportBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.communicateBtn1.mas_right).offset(2);
            make.width.mas_equalTo((SCREEN_WIDTH - 14 - 4) / 3);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(43);
        }];
    }
    
}

- (UIButton *)previewHomeworkBtn
{
    if (!_previewHomeworkBtn) {
        _previewHomeworkBtn = [[UIButton alloc] init];
//        [_previewHomeworkBtn setImage:[UIImage imageNamed:@"previewHomework"] forState:UIControlStateNormal];
//        [_previewHomeworkBtn sizeToFit];
        [_previewHomeworkBtn setTitle:@"预习作业" forState:UIControlStateNormal];
        [_previewHomeworkBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_previewHomeworkBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _previewHomeworkBtn.layer.cornerRadius = 21.5;
        _previewHomeworkBtn.layer.masksToBounds = YES;
        _previewHomeworkBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _previewHomeworkBtn.layer.borderWidth = 0.5;
        _previewHomeworkBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _previewHomeworkBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _previewHomeworkBtn.layer.shadowOpacity = 0.8f;
        _previewHomeworkBtn.layer.shadowRadius = 21.3;
    }
    return _previewHomeworkBtn;
}

- (UIButton *)courseFinishBtn
{
    if (!_courseFinishBtn) {
        _courseFinishBtn = [[UIButton alloc] init];
//        [_courseFinishBtn setImage:[UIImage imageNamed:@"courseFinish"] forState:UIControlStateNormal];
//        [_courseFinishBtn sizeToFit];
        [_courseFinishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_courseFinishBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_courseFinishBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _courseFinishBtn.layer.cornerRadius = 21.5;
        _courseFinishBtn.layer.masksToBounds = YES;
        _courseFinishBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _courseFinishBtn.layer.borderWidth = 0.5;
        _courseFinishBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _courseFinishBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _courseFinishBtn.layer.shadowOpacity = 0.8f;
        _courseFinishBtn.layer.shadowRadius = 21.3;
    }
    return _courseFinishBtn;
}

- (UIButton *)communicateBtn
{
    if (!_communicateBtn) {
        _communicateBtn = [[UIButton alloc] init];
//        [_communicateBtn setImage:[UIImage imageNamed:@"communicate"] forState:UIControlStateNormal];
//        [_communicateBtn sizeToFit];
        [_communicateBtn setTitle:@"沟通" forState:UIControlStateNormal];
        [_communicateBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_communicateBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _communicateBtn.layer.cornerRadius = 21.5;
        _communicateBtn.layer.masksToBounds = YES;
        _communicateBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _communicateBtn.layer.borderWidth = 0.5;
        _communicateBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _communicateBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _communicateBtn.layer.shadowOpacity = 0.8f;
        _communicateBtn.layer.shadowRadius = 21.3;
    }
    return _communicateBtn;
}

- (UIButton *)afterHomeworkBtn
{
    if (!_afterHomeworkBtn) {
        _afterHomeworkBtn = [[UIButton alloc] init];
        [_afterHomeworkBtn setTitle:@"课后作业" forState:UIControlStateNormal];
        [_afterHomeworkBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_afterHomeworkBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _afterHomeworkBtn.layer.cornerRadius = 21.5;
        _afterHomeworkBtn.layer.masksToBounds = YES;
        _afterHomeworkBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _afterHomeworkBtn.layer.borderWidth = 0.5;
        _afterHomeworkBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _afterHomeworkBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _afterHomeworkBtn.layer.shadowOpacity = 0.8f;
        _afterHomeworkBtn.layer.shadowRadius = 21.3;
    }
    return _afterHomeworkBtn;
}

- (UIButton *)appraiseBtn
{
    if (!_appraiseBtn) {
        _appraiseBtn = [[UIButton alloc] init];
        [_appraiseBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [_appraiseBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_appraiseBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _appraiseBtn.layer.cornerRadius = 21.5;
        _appraiseBtn.layer.masksToBounds = YES;
        _appraiseBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _appraiseBtn.layer.borderWidth = 0.5;
        _appraiseBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _appraiseBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _appraiseBtn.layer.shadowOpacity = 0.8f;
        _appraiseBtn.layer.shadowRadius = 21.3;
    }
    return _appraiseBtn;
}

- (UIButton *)communicateBtn1
{
    if (!_communicateBtn1) {
        _communicateBtn1 = [[UIButton alloc] init];
        [_communicateBtn1 setTitle:@"沟通" forState:UIControlStateNormal];
        [_communicateBtn1 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_communicateBtn1 setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _communicateBtn1.layer.cornerRadius = 21.5;
        _communicateBtn1.layer.masksToBounds = YES;
        _communicateBtn1.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _communicateBtn1.layer.borderWidth = 0.5;
        _communicateBtn1.layer.shadowColor = [[UIColor blackColor] CGColor];
        _communicateBtn1.layer.shadowOffset = CGSizeMake(1, 1);
        _communicateBtn1.layer.shadowOpacity = 0.8f;
        _communicateBtn1.layer.shadowRadius = 21.3;
    }
    return _communicateBtn1;
}

- (UIButton *)takeOrderBtn
{
    if (!_takeOrderBtn) {
        _takeOrderBtn = [[UIButton alloc] init];
        [_takeOrderBtn setTitle:@"抢单" forState:UIControlStateNormal];
        [_takeOrderBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_takeOrderBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _takeOrderBtn.layer.cornerRadius = 21.5;
        _takeOrderBtn.layer.masksToBounds = YES;
        _takeOrderBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _takeOrderBtn.layer.borderWidth = 0.5;
        _takeOrderBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _takeOrderBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _takeOrderBtn.layer.shadowOpacity = 0.8f;
        _takeOrderBtn.layer.shadowRadius = 21.3;
    }
    return _takeOrderBtn;
}

- (UIButton *)reportBtn
{
    if (!_reportBtn) {
        _reportBtn = [[UIButton alloc] init];
        [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_reportBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reportBtn setTitleColor:[UIColor colorWithHexString:@"#1aabfd"] forState:UIControlStateNormal];
        _reportBtn.layer.cornerRadius = 21.5;
        _reportBtn.layer.masksToBounds = YES;
        _reportBtn.layer.borderColor = [[UIColor colorWithHexString:@"#000000" alpha:0.2] CGColor];
        _reportBtn.layer.borderWidth = 0.5;
        _reportBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
        _reportBtn.layer.shadowOffset = CGSizeMake(1, 1);
        _reportBtn.layer.shadowOpacity = 0.8f;
        _reportBtn.layer.shadowRadius = 21.3;
    }
    return _reportBtn;
}

@end
