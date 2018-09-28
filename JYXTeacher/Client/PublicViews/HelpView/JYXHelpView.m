//
//  JYXHelpView.m
//  JYXTeacher
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHelpView.h"
@interface JYXHelpView ()
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation JYXHelpView
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
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(20);
        make.right.bottom.equalTo(self).offset(-20);
    }];
}

- (void)setHelpContent:(NSString *)helpContent
{
    _helpContent = helpContent;
    self.contentLabel.text = helpContent;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        _contentLabel.font = FONT_SIZE(15);
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

@end
