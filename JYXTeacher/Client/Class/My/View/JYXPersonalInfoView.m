//
//  JYXPersonalInfoView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXPersonalInfoView.h"
#import "JYXHomeBasePicuploadApi.h"
#import "JYXHomeTeacherTeacherEditApi.h"
#import "JYXChangeNicknameViewController.h"

@interface JYXPersonalInfoView ()
@property (nonatomic, strong) UIView *avatarBgView;
@property (nonatomic, strong) UILabel *avatarTitleLabel;
@property (nonatomic, strong) UIImageView *avatarImg;

@property (nonatomic, strong) UIView *nicknameBgView;
@property (nonatomic, strong) UILabel *nicknameTitleLabel;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *arrowImg1;

@property (nonatomic, strong) UIView *nameBgView;
@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *genderBgView;
@property (nonatomic, strong) UILabel *genderTitleLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UIImageView *arrowImg2;

@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation JYXPersonalInfoView
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
    [self addSubview:self.avatarBgView];
    [self.avatarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    [self.avatarBgView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.avatarBgView).offset(-15);
        make.top.equalTo(self.avatarBgView).offset(15);
        make.height.width.equalTo(@50);
        make.bottom.equalTo(self.avatarBgView).offset(-15);
    }];
    
    [self.avatarBgView addSubview:self.avatarTitleLabel];
    [self.avatarTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarBgView);
        make.left.equalTo(self.avatarBgView).offset(15);
    }];
    
//    [self addSubview:self.nicknameBgView];
//    [self.nicknameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.avatarBgView.mas_bottom).offset(1);
//        make.height.offset(44);
//    }];
//
//    [self.nicknameBgView addSubview:self.nicknameTitleLabel];
//    [self.nicknameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.nicknameBgView);
//        make.left.equalTo(self.nicknameBgView).offset(15);
//    }];
//
//    [self.nicknameBgView addSubview:self.arrowImg1];
//    [self.arrowImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.nicknameBgView).offset(-15);
//        make.centerY.equalTo(self.nicknameBgView);
//        make.height.offset(16);
//        make.width.offset(9);
//    }];
//
//    [self.nicknameBgView addSubview:self.nicknameLabel];
//    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.arrowImg1.mas_left).offset(-21);
//        make.centerY.equalTo(self.nicknameBgView);
//    }];
    
    [self addSubview:self.nameBgView];
    [self.nameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.avatarBgView.mas_bottom).offset(5);
        make.height.offset(44);
    }];
    
    [self.nameBgView addSubview:self.nameTitleLabel];
    [self.nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameBgView);
        make.left.equalTo(self.nameBgView).offset(15);
    }];
    
    [self.nameBgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameBgView).offset(-15);
        make.centerY.equalTo(self.nameBgView);
    }];
    
    [self addSubview:self.genderBgView];
    [self.genderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.nameBgView.mas_bottom).offset(1);
        make.height.offset(44);
    }];
    
    [self.genderBgView addSubview:self.genderTitleLabel];
    [self.genderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.genderBgView);
        make.left.equalTo(self.genderBgView).offset(15);
    }];
    
    [self.genderBgView addSubview:self.arrowImg2];
    [self.arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.genderBgView).offset(-15);
        make.centerY.equalTo(self.genderBgView);
        make.height.offset(16);
        make.width.offset(9);
    }];
    
    [self.genderBgView addSubview:self.genderLabel];
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg2.mas_left).offset(-21);
        make.centerY.equalTo(self.genderBgView);
    }];
//    
//    [self addSubview:self.saveBtn];
//    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(17);
//        make.right.equalTo(self).offset(-17);
//        make.height.offset(46);
//        make.top.equalTo(self.genderBgView.mas_bottom).offset(39);
//    }];
}

- (void)configPersonalInfoViewWithData:(id)model
{
    if (!model) return;
    JYXUser *user = [JYXUserManager shareInstance].user;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.nicknameLabel.text = user.nickname;
    self.nameLabel.text = user.cardname;
    self.genderLabel.text = user.sex;
}

//修改头像
- (void)changeAvatarAction:(UITapGestureRecognizer *)tap
{
    //图片选择器
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
    WeakSelf(weakSelf);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakSelf uploadPhotos:photos.firstObject];
    }];
}

//上传照片
- (void)uploadPhotos:(UIImage *)photo
{
    JYXHomeBasePicuploadApi *api = [[JYXHomeBasePicuploadApi alloc] initWithFile:@[photo]];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [self changeTeacherInfo:dict[@"picaddr"]];
        self.avatarImg.image = photo;
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//修改个人信息
- (void)changeTeacherInfo:(NSString *)head
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname head:head];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            [MBProgressHUD showInfoMessage:@"修改成功！"];
        }
        
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)changeNicknameAction:(UITapGestureRecognizer *)tap
{
    JYXChangeNicknameViewController *vc = [[JYXChangeNicknameViewController alloc] init];
    [vc setResult:@{@"nickname":self.nicknameLabel.text}];
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

//性别选择
- (void)sexAction:(UITapGestureRecognizer *)gesture
{
    WeakSelf(weakSelf);
    NSArray *array = @[@"男",@"女"];
    MSActionSheet *sexActionSheet = [[MSActionSheet alloc] initWithTitleAndCancel:nil cancel:nil cancelHandler:nil buttons:array handler:^(MSActionSheet *sheet, int btnIndex) {
        weakSelf.genderLabel.text = array[btnIndex];
        [weakSelf changeTeacherSex:array[btnIndex]];
    }];
    [sexActionSheet show];
}

//修改个人信息
- (void)changeTeacherSex:(NSString *)sex
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname nick:nil sex:sex];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            [MBProgressHUD showInfoMessage:@"修改成功！"];
        }
        
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (UIView *)avatarBgView
{
    if (!_avatarBgView) {
        _avatarBgView = [[UIView alloc] init];
        _avatarBgView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatarAction:)];
        [_avatarBgView addGestureRecognizer:tap];
    }
    return _avatarBgView;
}

- (UILabel *)avatarTitleLabel
{
    if (!_avatarTitleLabel) {
        _avatarTitleLabel = [[UILabel alloc] init];
        _avatarTitleLabel.text = NSLocalizedString(@"头像", nil);
        _avatarTitleLabel.font = FONT_SIZE(17);
        _avatarTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_avatarTitleLabel sizeToFit];
    }
    return _avatarTitleLabel;
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.contentMode = UIViewContentModeScaleToFill;
        JYXViewBorderRadius(_avatarImg, 50/2.0, 0, [UIColor clearColor]);
        _avatarImg.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatarAction:)];
//        [_avatarImg addGestureRecognizer:tap];
    }
    return _avatarImg;
}

- (UIView *)nicknameBgView
{
    if (!_nicknameBgView) {
        _nicknameBgView = [[UIView alloc] init];
        _nicknameBgView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNicknameAction:)];
        [_nicknameBgView addGestureRecognizer:tap];
    }
    return _nicknameBgView;
}

- (UILabel *)nicknameTitleLabel
{
    if (!_nicknameTitleLabel) {
        _nicknameTitleLabel = [[UILabel alloc] init];
        _nicknameTitleLabel.text = NSLocalizedString(@"昵称", nil);
        _nicknameTitleLabel.font = FONT_SIZE(17);
        _nicknameTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_nicknameTitleLabel sizeToFit];
    }
    return _nicknameTitleLabel;
}

- (UILabel *)nicknameLabel
{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = FONT_SIZE(15);
        _nicknameLabel.textColor = [UIColor colorWithHex:0x555555];
        [_nicknameLabel sizeToFit];
    }
    return _nicknameLabel;
}

- (UIImageView *)arrowImg1
{
    if (!_arrowImg1) {
        _arrowImg1 = [[UIImageView alloc] init];
        _arrowImg1.image = [UIImage imageNamed:@"rightArrow"];
        _arrowImg1.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg1;
}

- (UIView *)nameBgView
{
    if (!_nameBgView) {
        _nameBgView = [[UIView alloc] init];
        _nameBgView.backgroundColor = [UIColor whiteColor];
    }
    return _nameBgView;
}

- (UILabel *)nameTitleLabel
{
    if (!_nameTitleLabel) {
        _nameTitleLabel = [[UILabel alloc] init];
        _nameTitleLabel.text = NSLocalizedString(@"真实姓名", nil);
        _nameTitleLabel.font = FONT_SIZE(17);
        _nameTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_nameTitleLabel sizeToFit];
    }
    return _nameTitleLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SIZE(15);
        _nameLabel.textColor = [UIColor colorWithHex:0x555555];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UIView *)genderBgView
{
    if (!_genderBgView) {
        _genderBgView = [[UIView alloc] init];
        _genderBgView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexAction:)];
        [_genderBgView addGestureRecognizer:tap];
    }
    return _genderBgView;
}

- (UILabel *)genderTitleLabel
{
    if (!_genderTitleLabel) {
        _genderTitleLabel = [[UILabel alloc] init];
        _genderTitleLabel.text = NSLocalizedString(@"性别", nil);
        _genderTitleLabel.font = FONT_SIZE(17);
        _genderTitleLabel.textColor = [UIColor colorWithHex:0x272727];
        [_genderTitleLabel sizeToFit];
    }
    return _genderTitleLabel;
}

- (UILabel *)genderLabel
{
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] init];
        _genderLabel.font = FONT_SIZE(15);
        _genderLabel.textColor = [UIColor colorWithHex:0x555555];
        [_genderLabel sizeToFit];
    }
    return _genderLabel;
}

- (UIImageView *)arrowImg2
{
    if (!_arrowImg2) {
        _arrowImg2 = [[UIImageView alloc] init];
        _arrowImg2.image = [UIImage imageNamed:@"rightArrow"];
        _arrowImg2.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg2;
}

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] init];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"personalInfoSave"] forState:UIControlStateNormal];
    }
    return _saveBtn;
}

@end
