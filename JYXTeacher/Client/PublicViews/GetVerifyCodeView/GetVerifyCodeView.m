//
//  GetVerifyCodeView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "GetVerifyCodeView.h"
@interface GetVerifyCodeView ()
@property (nonatomic, strong) UIButton *titleBtn;
@end

@implementation GetVerifyCodeView
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
    [self addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
    }];
}

- (void)getCodeAction:(UIButton *)btn
{
    if (self.getCodeBlock) {
        BOOL isCan = self.getCodeBlock();
        if (isCan) {
            [self openCountdown];
        }
    }
}

// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.titleBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.titleBtn setTitleColor:[UIColor colorWithHexString:@"1aabfd"] forState:UIControlStateNormal];
                self.titleBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.titleBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [self.titleBtn setTitleColor:[UIColor colorWithHexString:@"1aabfd"] forState:UIControlStateNormal];
                self.titleBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark-- setter getter method
- (UIButton *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [[UIButton alloc] init];
        [_titleBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtn setTitle:NSLocalizedString(@"发送验证码", nil) forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = FONT_SIZE(15);
        [_titleBtn setTitleColor:[UIColor colorWithHex:0xb8b8b8] forState:UIControlStateNormal];
        [_titleBtn sizeToFit];
    }
    return _titleBtn;
}

@end
