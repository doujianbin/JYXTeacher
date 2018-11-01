//
//  JYXCoursePersonNumberView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCoursePersonNumberView.h"
@interface JYXCoursePersonNumberView ()

@property (nonatomic, strong) UIView      *v_person;
@property (nonatomic, strong) UIImageView *verticalBarImg;
@property (nonatomic, strong) UILabel *personNumberTitleLabel;
@property (nonatomic, strong) UILabel *personNumber;
@property (nonatomic, strong) UIImageView *myAvatarImg;
@property (nonatomic, strong) UILabel *mySelfLabel;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation JYXCoursePersonNumberView
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
    
    [self addSubview:self.v_person];
    [self.v_person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(30);
    }];
    
    [self.v_person addSubview:self.verticalBarImg];
    [self.verticalBarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(self).offset(11);
        make.width.offset(5);
        make.height.offset(17);
    }];
    
    [self.v_person addSubview:self.personNumberTitleLabel];
    [self.personNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg.mas_right).offset(3);
        make.centerY.equalTo(self.verticalBarImg);
    }];
    
    [self.v_person addSubview:self.personNumber];
    [self.personNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personNumberTitleLabel.mas_right).offset(3);
        make.centerY.equalTo(self.verticalBarImg);
        make.right.equalTo(self.mas_right).offset(-13);
    }];
    
    
//    [self addSubview:self.myAvatarImg];
//    [self.myAvatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(7);
//        make.top.equalTo(self.verticalBarImg.mas_bottom).offset(11);
//        make.width.height.offset(41);
//    }];
//
//    [self addSubview:self.mySelfLabel];
//    [self.mySelfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.myAvatarImg);
//        make.top.equalTo(self.myAvatarImg.mas_bottom).offset(6);
//        make.bottom.equalTo(self).offset(-103);
//    }];
//
//    [self addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.myAvatarImg.mas_right).offset(30);
//        make.top.equalTo(self.myAvatarImg);
//        make.bottom.equalTo(self.mySelfLabel);
//        make.right.equalTo(self).offset(-7);
//    }];
}

- (void)configCoursePersonNumberViewWithData:(id)model
{
    if (!model) return;
    [self.personNumber setText:[NSString stringWithFormat:@"%@人",model[@"people"]]];
}

- (UIView *)v_person{
    if (!_v_person) {
        _v_person = [[UIView alloc]init];
        [_v_person setBackgroundColor:[UIColor whiteColor]];
    }
    return _v_person;
}

- (UIImageView *)verticalBarImg
{
    if (!_verticalBarImg) {
        _verticalBarImg = [[UIImageView alloc] init];
        _verticalBarImg.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg;
}

- (UILabel *)personNumberTitleLabel
{
    if (!_personNumberTitleLabel) {
        _personNumberTitleLabel = [[UILabel alloc] init];
        _personNumberTitleLabel.text = NSLocalizedString(@"上课人数", nil);
        _personNumberTitleLabel.textColor = [UIColor colorWithHex:0x000000];
        _personNumberTitleLabel.font = FONT_SIZE(16);
        [_personNumberTitleLabel sizeToFit];
    }
    return _personNumberTitleLabel;
}

- (UILabel *)personNumber
{
    if (!_personNumber) {
        _personNumber = [[UILabel alloc] init];
//        _personNumber.text = NSLocalizedString(@"2人", nil);
        _personNumber.textColor = [UIColor colorWithHex:0x000000];
        _personNumber.font = FONT_SIZE(16);
        [_personNumber sizeToFit];
        [_personNumber setTextAlignment:NSTextAlignmentRight];
    }
    return _personNumber;
}

- (UIImageView *)myAvatarImg
{
    if (!_myAvatarImg) {
        _myAvatarImg = [[UIImageView alloc] init];
        JYXViewBorderRadius(_myAvatarImg, 41/2.0, 0, [UIColor clearColor]);
        _myAvatarImg.contentMode = UIViewContentModeScaleAspectFill;
        [_myAvatarImg sd_setImageWithURL:[NSURL URLWithString:[JYXUserManager shareInstance].user.avatar] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    }
    return _myAvatarImg;
}

- (UILabel *)mySelfLabel
{
    if (!_mySelfLabel) {
        _mySelfLabel = [[UILabel alloc] init];
        _mySelfLabel.textColor = [UIColor colorWithHex:0x434343];
        _mySelfLabel.text = NSLocalizedString(@"我", nil);
        _mySelfLabel.font = FONT_SIZE(13);
        [_mySelfLabel sizeToFit];
    }
    return _mySelfLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

@end
