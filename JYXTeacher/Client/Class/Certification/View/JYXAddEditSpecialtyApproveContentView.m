//
//  JYXAddEditSpecialtyApproveContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAddEditSpecialtyApproveContentView.h"
#import "JYXPhotoView.h"
#import "JYXHomeBasePicuploadApi.h"
#import "JYXHomeTeacherSubjectAddApi.h"
#import "JYXAddEditApproveCollectionViewCell.h"
#import "JYXHomeTeacherSubjectEditApi.h"

@interface JYXAddEditSpecialtyApproveContentView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSDictionary *_dictModel;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UITextField *subjectNameField;
@property (nonatomic, strong) JYXPhotoView *photoView;
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIButton *submitPhoto;
@property (nonatomic, strong) UILabel *alreadyUploadPhotoLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *picArray;
@end

@implementation JYXAddEditSpecialtyApproveContentView
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
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
    }];
    
    [self addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.subjectNameField];
    [self.subjectNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(10);
        make.height.offset(40);
    }];
    
    [self addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subjectNameField.mas_bottom).offset(30);
        make.left.right.equalTo(self.subjectNameField);
        make.height.greaterThanOrEqualTo(@100);
    }];
    
    [self addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.photoView.mas_bottom).offset(30);
    }];
    
    [self addSubview:self.submitPhoto];
    [self.submitPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(20);
        make.height.offset(30);
        make.width.offset(100);
    }];
    
    [self addSubview:self.alreadyUploadPhotoLabel];
    [self.alreadyUploadPhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.submitPhoto.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.alreadyUploadPhotoLabel.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-20);
    }];
}

- (void)configAddEditSpecialtyApproveViewWithData:(id)model
{
    if (!model) return;
    if ([model[@"source"] integerValue] == 1) {//添加专业认证
        self.alreadyUploadPhotoLabel.hidden = YES;
    } else {
        self.alreadyUploadPhotoLabel.hidden = NO;
        self.subjectNameField.text = model[@"name"];
    }
    self.picArray = [model[@"pic"] componentsSeparatedByString:@","];
    _dictModel = model;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(170);
    }];
    [self.collectionView reloadData];
}

//提交
- (void)submitPhotosAction:(UIButton *)btn
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    if ([_dictModel[@"source"] integerValue] == 1) {
        JYXHomeTeacherSubjectAddApi *api = [[JYXHomeTeacherSubjectAddApi alloc] initWithUserid:user.userId WithToken:user.token subjectid:_dictModel[@"approveCount"] subjectname:[self.subjectNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] pic:[self.urlArray componentsJoinedByString:@","]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [WLToast show:@"添加成功！"];
            [[JYXBaseViewController getCurrentVC].navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    } else {
        JYXHomeTeacherSubjectEditApi *api = [[JYXHomeTeacherSubjectEditApi alloc] initWithUserid:user.userId WithToken:user.token subjectid:_dictModel[@"id"] subjectname:[self.subjectNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] pic:[self.urlArray componentsJoinedByString:@","] keyword:_dictModel[@"keyword"]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [WLToast show:@"修改成功！"];
            [[JYXBaseViewController getCurrentVC].navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

//上传照片
- (void)uploadPhotos:(UIImage *)photo
{
    UIImage *tmpPhoto = photo;
    JYXHomeBasePicuploadApi *api = [[JYXHomeBasePicuploadApi alloc] initWithFile:@[photo]];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [self.urlArray addObject:dict[@"picaddr"]];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self uploadPhotos:tmpPhoto];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAddEditApproveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYXAddEditApproveCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[indexPath.row]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArray.count;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.text = NSLocalizedString(@"认证越全面，越能获得学生信任", nil);
        _titleLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = FONT_SIZE(15);
        _subtitleLabel.text = NSLocalizedString(@"专业认证", nil);
        _subtitleLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        [_subtitleLabel sizeToFit];
    }
    return _subtitleLabel;
}

- (UITextField *)subjectNameField
{
    if (!_subjectNameField) {
        _subjectNameField = [[UITextField alloc] init];
        _subjectNameField.placeholder = NSLocalizedString(@"请输入专业认证名称", nil);
        _subjectNameField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _subjectNameField.leftViewMode = UITextFieldViewModeAlways;
        _subjectNameField.textColor = [UIColor colorWithHex:0x5d5d5d];
        _subjectNameField.font = FONT_SIZE(15);
        JYXViewBorderRadius(_subjectNameField, 3, 1, [UIColor colorWithHex:0x5d5d5d]);
        [_subjectNameField sizeToFit];
    }
    return _subjectNameField;
}

- (JYXPhotoView *)photoView
{
    if (!_photoView) {
        _photoView = [[JYXPhotoView alloc] init];
        WeakSelf(weakSelf);
        [_photoView setPictureSelectSuccess:^(NSArray *photos) {
            StrongSelf(strongSelf);
            strongSelf.photoArr = [photos mutableCopy];
            for (UIImage *photo in photos) {
                [strongSelf uploadPhotos:photo];
            }
        }];
    }
    return _photoView;
}

- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.text = NSLocalizedString(@"国家承认证书：如英语专业八级、语文甲级\n重新上传，将覆盖之前的所有图片", nil);
        _remarkLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        _remarkLabel.font = FONT_SIZE(15);
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.textAlignment = NSTextAlignmentCenter;
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UIButton *)submitPhoto
{
    if (!_submitPhoto) {
        _submitPhoto = [[UIButton alloc] init];
        _submitPhoto.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_submitPhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitPhoto setTitle:NSLocalizedString(@"上传照片", nil) forState:UIControlStateNormal];
        _submitPhoto.titleLabel.font = FONT_SIZE(15);
        JYXViewBorderRadius(_submitPhoto, 15, 0, [UIColor clearColor]);
        [_submitPhoto addTarget:self action:@selector(submitPhotosAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitPhoto sizeToFit];
    }
    return _submitPhoto;
}

- (UILabel *)alreadyUploadPhotoLabel
{
    if (!_alreadyUploadPhotoLabel) {
        _alreadyUploadPhotoLabel = [[UILabel alloc] init];
        _alreadyUploadPhotoLabel.text = NSLocalizedString(@"已上传图片", nil);
        _alreadyUploadPhotoLabel.font = FONT_SIZE(15);
        _alreadyUploadPhotoLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        [_alreadyUploadPhotoLabel sizeToFit];
    }
    return _alreadyUploadPhotoLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[JYXAddEditApproveCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JYXAddEditApproveCollectionViewCell class])];
    }
    return _collectionView;
}

@end
