//
//  JYXCourseHomeworkContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseHomeworkContentView.h"
#import "JYXPhotoView.h"
#import "JYXHomeBasePicuploadApi.h"

#define MaxPhotoCount 6
@interface JYXCourseHomeworkContentView ()<UITextViewDelegate>
@property (nonatomic, strong) UIImageView *verticalBarImg1;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;

@property (nonatomic, strong) UIImageView *verticalBarImg2;
@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UILabel *photoNumberLabel;

@property (nonatomic, strong) JYXPhotoView   *photoView;
@property (nonatomic,strong) NSMutableArray         *photoArr;
@property(nonatomic,strong) NSMutableArray          *urlArray;

@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation JYXCourseHomeworkContentView
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
    [self addSubview:self.verticalBarImg1];
    [self.verticalBarImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self).offset(20);
        make.width.offset(9);
        make.height.offset(24);
    }];
    
    [self addSubview:self.titleLabel1];
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg1.mas_right).offset(8);
        make.centerY.equalTo(self.verticalBarImg1);
    }];
    
    [self addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.top.equalTo(self.verticalBarImg1.mas_bottom).offset(13);
        make.height.offset(150);
    }];
    
    [self addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentTextView).offset(-5);
    }];
    
    [self addSubview:self.verticalBarImg2];
    [self.verticalBarImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self.contentTextView.mas_bottom).offset(30);
        make.width.offset(9);
        make.height.offset(24);
    }];
    
    [self addSubview:self.titleLabel2];
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg2.mas_right).offset(8);
        make.centerY.equalTo(self.verticalBarImg2);
    }];
    
    [self addSubview:self.photoNumberLabel];
    [self.photoNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self.verticalBarImg2);
    }];
    
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(125);
        make.height.offset(35);
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel2.mas_bottom).offset(248);
        make.bottom.equalTo(self).offset(-65);
    }];
    
    [self addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.top.equalTo(self.titleLabel2.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-35);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
    
    //图片选择完成回调
    WeakSelf(weakSelf);
    [self.photoView setPictureSelectSuccess:^(NSArray *photos) {
        StrongSelf(strongSelf);
        strongSelf.photoArr = [photos mutableCopy];
        strongSelf.photoNumberLabel.text = [NSString stringWithFormat:@"%ld/%d",photos.count,MaxPhotoCount];
        
        for (UIImage *photo in photos) {
            [strongSelf uploadPhotos:photo];
        }
        
    }];
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

//发布作业
- (void)submitAction:(UIButton *)btn
{
    NSDictionary *dict = @{@"content":self.contentTextView.text?:@"", @"photos":[self.urlArray componentsJoinedByString:@","]};
    if (self.releaseHomeworkBlock) {
        self.releaseHomeworkBlock(dict);
    }
}

#pragma mark        textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    } else {
        
        if (textView.text.length - range.length + text.length > 300) {
            [MBProgressHUD showInfoMessage:@"不能超过300个字"];
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel1.text = [NSString stringWithFormat:@"%@",title];
    self.titleLabel2.text = [NSString stringWithFormat:@"添加%@的相关截图和照片",title];
}

- (UIImageView *)verticalBarImg1
{
    if (!_verticalBarImg1) {
        _verticalBarImg1 = [[UIImageView alloc] init];
        _verticalBarImg1.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg1;
}

- (UILabel *)titleLabel1
{
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc] init];
        _titleLabel1.text = NSLocalizedString(@"yu'xi作业", nil);
        _titleLabel1.font = FONT_SIZE(15);
        _titleLabel1.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_titleLabel1 sizeToFit];
    }
    return _titleLabel1;
}

- (UITextView *)contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        JYXViewBorderRadius(_contentTextView, 10, 1, [UIColor colorWithHex:0xc1c1c1]);
        _contentTextView.placeholder = NSLocalizedString(@"请输入作业内容\n一旦填写完成，将显示在学生端的我的作业中", nil);
        _contentTextView.font = FONT_SIZE(12);
        _contentTextView.delegate = self;
        _contentTextView.textColor = [UIColor colorWithHex:0x6d6d6d];
        _contentTextView.contentInset = EdgeInsets(10, 10, 20, 10);
    }
    return _contentTextView;
}

- (UILabel *)wordNumberLabel
{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
        _wordNumberLabel.font = FONT_SIZE(13);
        _wordNumberLabel.text = @"0/300";
        _wordNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        [_wordNumberLabel sizeToFit];
    }
    return _wordNumberLabel;
}

- (UIImageView *)verticalBarImg2
{
    if (!_verticalBarImg2) {
        _verticalBarImg2 = [[UIImageView alloc] init];
        _verticalBarImg2.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg2;
}

- (UILabel *)titleLabel2
{
    if (!_titleLabel2) {
        _titleLabel2 = [[UILabel alloc] init];
        _titleLabel2.text = NSLocalizedString(@"添加课前作业的相关截图和照片", nil);
        _titleLabel2.font = FONT_SIZE(15);
        _titleLabel2.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_titleLabel2 sizeToFit];
    }
    return _titleLabel2;
}

- (UILabel *)photoNumberLabel
{
    if (!_photoNumberLabel) {
        _photoNumberLabel = [[UILabel alloc] init];
        _photoNumberLabel.text = [NSString stringWithFormat:@"0/%d",MaxPhotoCount];
        _photoNumberLabel.font = FONT_SIZE(12);
        _photoNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        [_photoNumberLabel sizeToFit];
    }
    return _photoNumberLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        _submitBtn.titleLabel.font = FONT_SIZE(16);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        JYXViewBorderRadius(_submitBtn, 18, 0, [UIColor clearColor]);
        [_submitBtn sizeToFit];
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (JYXPhotoView *)photoView
{
    if (!_photoView) {
        _photoView = [[JYXPhotoView alloc] init];
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

@end
