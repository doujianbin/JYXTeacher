//
//  JYXCourseDemandView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseDemandView.h"
@interface JYXCourseDemandView ()<UITextViewDelegate>
@property (nonatomic, strong) UIImageView *verticalBarImg;
@property (nonatomic, strong) UILabel *demandTitleLabel;
@property (nonatomic, strong) UITextView *demandTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;
@end

@implementation JYXCourseDemandView
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
    [self addSubview:self.verticalBarImg];
    [self.verticalBarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(self).offset(11);
        make.width.offset(5);
        make.height.offset(17);
    }];
    
    [self addSubview:self.demandTitleLabel];
    [self.demandTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg.mas_right).offset(3);
        make.centerY.equalTo(self.verticalBarImg);
    }];
    
    [self addSubview:self.demandTextView];
    [self.demandTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self.verticalBarImg.mas_bottom).offset(11);
        make.height.offset(64);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.demandTextView).offset(-5);
    }];
}

- (void)configCourseDemandViewWithData:(id)model
{
    if (!model) return;
    self.demandTextView.text = model[@"remark"];
}

#pragma mark        textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }
    else {
        
        if (textView.text.length - range.length + text.length > 300) {
            [WLToast show:@"不能超过300个字"];
            return NO;
        } else {
            return YES;
        }
        
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
}

- (UIImageView *)verticalBarImg
{
    if (!_verticalBarImg) {
        _verticalBarImg = [[UIImageView alloc] init];
        _verticalBarImg.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg;
}

- (UILabel *)demandTitleLabel
{
    if (!_demandTitleLabel) {
        _demandTitleLabel = [[UILabel alloc] init];
        _demandTitleLabel.text = NSLocalizedString(@"需求描述", nil);
        _demandTitleLabel.textColor = [UIColor colorWithHex:0x000000];
        _demandTitleLabel.font = FONT_SIZE(16);
        [_demandTitleLabel sizeToFit];
    }
    return _demandTitleLabel;
}

- (UITextView *)demandTextView
{
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] init];
        JYXViewBorderRadius(_demandTextView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
        _demandTextView.contentInset = EdgeInsets(7, 9, 22, 9);
        _demandTextView.font = FONT_SIZE(14);
        _demandTextView.delegate = self;
        _demandTextView.textColor = [UIColor colorWithHex:0x8f8f8f];
    }
    return _demandTextView;
}

- (UILabel *)wordNumberLabel
{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
//        _wordNumberLabel.text = @"0/300";
        _wordNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        _wordNumberLabel.font = FONT_SIZE(13);
        [_wordNumberLabel sizeToFit];
    }
    return _wordNumberLabel;
}

@end
