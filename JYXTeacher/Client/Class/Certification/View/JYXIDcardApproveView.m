//
//  JYXIDcardApproveView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXIDcardApproveView.h"
#import "JYXHomeBasePicuploadApi.h"
#import "JYXHomeTeacherCardAuthApi.h"

@interface JYXIDcardApproveView ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIButton *idcardFrontAdd;
@property (nonatomic, strong) UILabel *idcardFrontLabel;

@property (nonatomic, strong) UIButton *idcardReverseAdd;
@property (nonatomic, strong) UILabel *idcardReverseLabel;

@property (nonatomic, strong) UIButton *workProveAdd;
@property (nonatomic, strong) UILabel *workProveLabel;

@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIButton *uploadBtn;

@property (nonatomic, strong) NSMutableArray *urlArray;
@end

@implementation JYXIDcardApproveView
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
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.offset(285);
        make.width.offset(300);
    }];
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, size.width, size.height);
    
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(18);
    }];
    
    [self.bgView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    
    [self.bgView addSubview:self.idcardFrontAdd];
    [self.idcardFrontAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(35);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(15);
        make.height.offset(42);
        make.width.offset(60);
    }];
    
    [self.bgView addSubview:self.idcardReverseAdd];
    [self.idcardReverseAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.centerY.equalTo(self.idcardFrontAdd);
        make.height.offset(42);
        make.width.offset(60);
    }];
    
    [self.bgView addSubview:self.workProveAdd];
    [self.workProveAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-35);
        make.centerY.equalTo(self.idcardFrontAdd);
        make.height.offset(42);
        make.width.offset(60);
    }];
    
    [self.bgView addSubview:self.idcardFrontLabel];
    [self.idcardFrontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.idcardFrontAdd);
        make.top.equalTo(self.idcardFrontAdd.mas_bottom).offset(12);
    }];
    
    [self.bgView addSubview:self.idcardReverseLabel];
    [self.idcardReverseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.idcardReverseAdd);
        make.centerY.equalTo(self.idcardFrontLabel);
    }];
    
    [self.bgView addSubview:self.workProveLabel];
    [self.workProveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.workProveAdd);
        make.centerY.equalTo(self.idcardFrontLabel);
    }];
    
    [self.bgView addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(35);
        make.right.equalTo(self.bgView).offset(-35);
        make.top.equalTo(self.idcardFrontLabel.mas_bottom).offset(15);
    }];
    
    [self.bgView addSubview:self.uploadBtn];
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(150);
        make.height.offset(30);
        make.centerX.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-18);
    }];
}

- (void)addPhotoAction:(UIButton *)btn
{
    //图片选择器
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
    WeakSelf(weakSelf);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakSelf uploadPhotos:photos.firstObject button:btn];
    }];
}

//上传照片
- (void)uploadPhotos:(UIImage *)photo button:(UIButton *)btn
{
    JYXHomeBasePicuploadApi *api = [[JYXHomeBasePicuploadApi alloc] initWithFile:@[photo]];
    if (btn.tag == 1) {
        api.url = @"home/teacher/card_picmatchfront";
    }else if (btn.tag == 2){
        api.url = @"home/teacher/card_picmatchback";
    }
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        if ([api.url isEqualToString:@"home/teacher/card_picmatchfront"] || [api.url isEqualToString:@"home/teacher/card_picmatchback"]) {
            if ([dict[@"error_code"] intValue] == 0) {
                [self.urlArray addObject:dict[@"picaddr"]];
                [btn setImage:photo forState:UIControlStateNormal];
            }else{
                [MBProgressHUD showInfoMessage:@"请上传正确的身份证图片"];
            }
        }else{
            [self.urlArray addObject:dict[@"picaddr"]];
            [btn setImage:photo forState:UIControlStateNormal];
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//提交
- (void)uploadAction:(UIButton *)btn
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"teacherType"] isEqualToString:@"全职教师"]) {
        if (self.urlArray.count != 3) {
            [MBProgressHUD showInfoMessage:@"您还未提交工作相关证明"];
            return;
        }
    }
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherCardAuthApi *api = [[JYXHomeTeacherCardAuthApi alloc] initWithUserid:user.userId WithToken:user.token pic:[self.urlArray componentsJoinedByString:@","]];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showInfoMessage:@"提交成功！"];
        if (self.submitSuccessBlock) {
            self.submitSuccessBlock();
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_bgView, 10, 0, [UIColor clearColor]);
    }
    return _bgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = NSLocalizedString(@"认证越全面，越能获得学生信任", nil);
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"teacherType"] isEqualToString:@"大学生"] || [[[NSUserDefaults standardUserDefaults] valueForKey:@"teacherType"] isEqualToString:@"自由教师"]) {
            _subTitleLabel.text = NSLocalizedString(@"身份证必填", nil);
        }else{
            _subTitleLabel.text = NSLocalizedString(@"必须上传身份证，工作相关证明", nil);
        }
        _subTitleLabel.font = FONT_SIZE(15);
        _subTitleLabel.textColor = [UIColor colorWithHexString:@"#FF7031"];
        [_subTitleLabel sizeToFit];
    }
    return _subTitleLabel;
}

- (UIButton *)idcardFrontAdd
{
    if (!_idcardFrontAdd) {
        _idcardFrontAdd = [[UIButton alloc] init];
        [_idcardFrontAdd setImage:[UIImage imageNamed:@"approve_add"] forState:UIControlStateNormal];
        _idcardFrontAdd.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _idcardFrontAdd.tag = 1;
        [_idcardFrontAdd addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _idcardFrontAdd;
}

- (UIButton *)idcardReverseAdd
{
    if (!_idcardReverseAdd) {
        _idcardReverseAdd = [[UIButton alloc] init];
        [_idcardReverseAdd setImage:[UIImage imageNamed:@"approve_add"] forState:UIControlStateNormal];
        _idcardReverseAdd.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _idcardReverseAdd.tag = 2;
        [_idcardReverseAdd addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _idcardReverseAdd;
}

- (UIButton *)workProveAdd
{
    if (!_workProveAdd) {
        _workProveAdd = [[UIButton alloc] init];
        [_workProveAdd setImage:[UIImage imageNamed:@"approve_add"] forState:UIControlStateNormal];
        _workProveAdd.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _workProveAdd.tag = 3;
        [_workProveAdd addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workProveAdd;
}

- (UILabel *)idcardFrontLabel
{
    if (!_idcardFrontLabel) {
        _idcardFrontLabel = [[UILabel alloc] init];
        _idcardFrontLabel.text = NSLocalizedString(@"身份证正面", nil);
        _idcardFrontLabel.font = FONT_SIZE(14);
        _idcardFrontLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_idcardFrontLabel sizeToFit];
    }
    return _idcardFrontLabel;
}

- (UILabel *)idcardReverseLabel
{
    if (!_idcardReverseLabel) {
        _idcardReverseLabel = [[UILabel alloc] init];
        _idcardReverseLabel.text = NSLocalizedString(@"身份证反面", nil);
        _idcardReverseLabel.font = FONT_SIZE(14);
        _idcardReverseLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_idcardReverseLabel sizeToFit];
    }
    return _idcardReverseLabel;
}

- (UILabel *)workProveLabel
{
    if (!_workProveLabel) {
        _workProveLabel = [[UILabel alloc] init];
        _workProveLabel.text = NSLocalizedString(@"工作相关证明", nil);
        _workProveLabel.font = FONT_SIZE(14);
        _workProveLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_workProveLabel sizeToFit];
    }
    return _workProveLabel;
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.text = NSLocalizedString(@"说明文字：如实填写相关信息，提交相关认证，有助于提高您的信誉度，得到学生信赖，获得更多课程订单。", nil);
        _remarkLabel.font = FONT_SIZE(12);
        _remarkLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _remarkLabel.numberOfLines = 0;
        [_remarkLabel sizeToFit];
        
    }
    return _remarkLabel;
}

- (UIButton *)uploadBtn
{
    if (!_uploadBtn) {
        _uploadBtn = [[UIButton alloc] init];
        _uploadBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        JYXViewBorderRadius(_uploadBtn, 15, 0, [UIColor clearColor]);
        [_uploadBtn setTitle:NSLocalizedString(@"上传照片", nil) forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _uploadBtn.titleLabel.font = FONT_SIZE(12);
        [_uploadBtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uploadBtn;
}

- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

@end
