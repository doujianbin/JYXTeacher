//
//  JYXTeachingMethodViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTeachingMethodViewController.h"
#import "JYXTeachingMethodContentView.h"
#import "TakeOrderSettingHandler.h"

@interface JYXTeachingMethodViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXTeachingMethodContentView *contentView;
@end

@implementation JYXTeachingMethodViewController
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
    self.navigationItem.title = NSLocalizedString(@"授课方式设置", nil);
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.mScrollView];
    [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mScrollView);
        make.width.equalTo(self.mScrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
}

- (void)loadData
{
    [self.contentView configTeachingMethodViewWithData:self.dic_data];
}

- (void)rightBarAction{
    
    if (self.contentView.studentVisitTitleSwitch.on == YES) {
        if ([self.contentView.addressLabel.text isEqualToString:@""] || [self.contentView.addressLabel.text isEqualToString:@"1"]) {
            [MBProgressHUD showInfoMessage:@"请先设置地址学生才能上门"];
            return;
        }
    }
    
    [TakeOrderSettingHandler postTeacherFangShiWithTeachertohome:self.contentView.teacherVisitTitleSwitch.on studenttohome:self.contentView.studentVisitTitleSwitch.on addr:self.contentView.addressLabel.text otheraddr:self.contentView.otherAddressTitleSwitch.on shareaddr:YES prepare:^{
        
    } success:^(id obj) {
        if (self.teacherClassComplete) {
            self.teacherClassComplete();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] init];
        _mScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mScrollView;
}

- (JYXTeachingMethodContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXTeachingMethodContentView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

@end

