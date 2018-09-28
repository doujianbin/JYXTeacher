//
//  JYXUserFeedbackViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXUserFeedbackViewController.h"

@interface JYXUserFeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton *feedbackType;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UITextView *feedbackTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;
@property (nonatomic, strong) UITextField *contactField;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIButton *phoneCallBtn;
@property (nonatomic, strong) UILabel *workdayLabel;
@end

@implementation JYXUserFeedbackViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"用户反馈", nil);
    [self loadData];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.feedbackType];
    [self.feedbackType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.top.equalTo(self.view).offset(7);
        make.right.equalTo(self.view).offset(-17);
        make.height.offset(46);
    }];
    
    [self.feedbackType addSubview:self.typeTitleLabel];
    [self.typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.feedbackType).offset(13);
        make.centerY.equalTo(self.feedbackType);
    }];
    
    [self.feedbackType addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.feedbackType).offset(-13);
        make.centerY.equalTo(self.feedbackType);
        make.height.offset(20);
        make.width.offset(15);
    }];
    
    [self.view addSubview:self.feedbackTextView];
    [self.feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedbackType.mas_bottom).offset(7);
        make.left.right.equalTo(self.feedbackType);
        make.height.offset(150);
    }];
    
    [self.view addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.feedbackTextView).offset(-5);
    }];
    
    [self.view addSubview:self.contactField];
    [self.contactField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedbackTextView.mas_bottom).offset(22);
        make.left.right.equalTo(self.feedbackType);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.feedbackType);
        make.top.equalTo(self.contactField.mas_bottom).offset(19);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.workdayLabel];
    [self.workdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-38);
    }];
    
    [self.view addSubview:self.phoneCallBtn];
    [self.phoneCallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.workdayLabel.mas_top);
    }];
    
    [self.view addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.phoneCallBtn.mas_top);
    }];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
#pragma mark        textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    } else {
        
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

#pragma mark - getters and setters          - Method -
- (UIButton *)feedbackType
{
    if (!_feedbackType) {
        _feedbackType = [[UIButton alloc] init];
        JYXViewBorderRadius(_feedbackType, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
    }
    return _feedbackType;
}

- (UILabel *)typeTitleLabel
{
    if (!_typeTitleLabel) {
        _typeTitleLabel = [[UILabel alloc] init];
        _typeTitleLabel.text = @"产品使用";
        _typeTitleLabel.textColor = [UIColor colorWithHex:0xc0c0c0];
        _typeTitleLabel.font = FONT_SIZE(12);
        [_typeTitleLabel sizeToFit];
    }
    return _typeTitleLabel;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@""];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}

- (UITextView *)feedbackTextView
{
    if (!_feedbackTextView) {
        _feedbackTextView = [[UITextView alloc] init];
        _feedbackTextView.placeholder = NSLocalizedString(@"请输入您的意见和建议， 我们将不断改进（必填） ", nil);
        _feedbackTextView.font = FONT_SIZE(12);
        _feedbackTextView.textColor = [UIColor colorWithHex:0xc0c0c0];
        JYXViewBorderRadius(_feedbackTextView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
        _feedbackTextView.contentInset = EdgeInsets(5, 7, 20, 7);
        _feedbackTextView.delegate = self;
    }
    return _feedbackTextView;
}

- (UILabel *)wordNumberLabel
{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
        _wordNumberLabel.text = @"0/300";
        _wordNumberLabel.font = FONT_SIZE(13);
        _wordNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        [_wordNumberLabel sizeToFit];
    }
    return _wordNumberLabel;
}

- (UITextField *)contactField
{
    if (!_contactField) {
        _contactField = [[UITextField alloc] init];
        _contactField.font = FONT_SIZE(12);
        _contactField.textColor = [UIColor colorWithHex:0xc0c0c0];
        _contactField.placeholder = NSLocalizedString(@"请留下您的邮箱或手机号（必填）", nil);
        JYXViewBorderRadius(_contactField, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
        _contactField.leftViewMode = UITextFieldViewModeAlways;
        _contactField.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    }
    return _contactField;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_submitBtn, 5, 0, [UIColor clearColor]);
    }
    return _submitBtn;
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = FONT_SIZE(12);
        _remarkLabel.text = NSLocalizedString(@"使用过程中遇到任何问题请致电", nil);
        _remarkLabel.textColor = [UIColor colorWithHex:0xababab];
        [_remarkLabel sizeToFit];
    }
    return _remarkLabel;
}

- (UIButton *)phoneCallBtn
{
    if (!_phoneCallBtn) {
        _phoneCallBtn = [[UIButton alloc] init];
        [_phoneCallBtn setTitle:NSLocalizedString(@"010-57214966", nil) forState:UIControlStateNormal];
        [_phoneCallBtn setTitleColor:[UIColor colorWithHex:0x6a6a6a] forState:UIControlStateNormal];
        _phoneCallBtn.titleLabel.font = FONT_SIZE(13);
        [_phoneCallBtn sizeToFit];
    }
    return _phoneCallBtn;
}

- (UILabel *)workdayLabel
{
    if (!_workdayLabel) {
        _workdayLabel = [[UILabel alloc] init];
        _workdayLabel.text = NSLocalizedString(@"工作日 09:00-17:00", nil);
        _workdayLabel.font = FONT_SIZE(11);
        _workdayLabel.textColor = [UIColor colorWithHex:0xababab];
        [_workdayLabel sizeToFit];
    }
    return _workdayLabel;
}

@end
