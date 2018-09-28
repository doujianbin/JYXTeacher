//
//  JYXAddEditApproveCollectionViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAddEditApproveCollectionViewCell.h"

@implementation JYXAddEditApproveCollectionViewCell
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
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
