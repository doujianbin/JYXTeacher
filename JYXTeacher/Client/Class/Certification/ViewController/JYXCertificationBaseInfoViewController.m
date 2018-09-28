//
//  JYXCertificationBaseInfoViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCertificationBaseInfoViewController.h"
#import "JYXBaseInfoContentView.h"
#import "MyHandler.h"

@interface JYXCertificationBaseInfoViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXBaseInfoContentView *contentView;
@property (nonatomic ,assign) int teacherStatus;
@property (nonatomic ,strong) NSDictionary *dic_data;
@end

@implementation JYXCertificationBaseInfoViewController
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
    self.navigationItem.title = NSLocalizedString(@"基本信息", nil);
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
//    [MyHandler selectTeacherBaseInfoPrepare:^{
//
//    } success:^(id obj) {
//        NSDictionary *dic = (NSDictionary *)obj;
//        NSLog(@"dic == %@",dic);
//        if ([[dic objectForKey:@"code"] intValue] == 1000) {
//            NSDictionary *dic_data = dic[@"result"];
//            JYXUser *user = [JYXUserManager shareInstance].user;
//            [user clear];
//            [user configUserData:dic_data];
//            [[JYXUserManager shareInstance] save];
//            [self.contentView configBaseInfoViewWithData:@{}];
////            if ([[dic_data objectForKey:@"cityname"] isEqualToString:@""]) {
////                //未传过基本信息
////
////            }else{
////            }
//        }else{
//            [MBProgressHUD showErrorMessage:[dic objectForKey:@"msg"]];
//        }
//
//
//    } failed:^(NSInteger statusCode, id json) {
//        self.teacherStatus = 0;
//    }];
    [self.contentView configBaseInfoViewWithData:@{}];
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

- (JYXBaseInfoContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXBaseInfoContentView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

@end
