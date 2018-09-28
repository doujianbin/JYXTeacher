//
//  JYXCourseHomeworkViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseHomeworkViewController.h"
#import "JYXCourseHomeworkContentView.h"
#import "JYXHomeTeacherHomeworkApi.h"
#import "TeacherWorkHandler.h"

@interface JYXCourseHomeworkViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) JYXCourseHomeworkContentView *contentView;
@end

@implementation JYXCourseHomeworkViewController
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
    if (_type.integerValue == 1) {
        self.contentView.title = self.navigationItem.title = NSLocalizedString(@"预习作业", nil);
        
    } else {
        self.contentView.title = self.navigationItem.title = NSLocalizedString(@"课后作业", nil);
    }
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
    
    //发布作业
    WeakSelf(weakSelf);
    [self.contentView setReleaseHomeworkBlock:^(NSDictionary *dict) {
        [weakSelf releaseHomework:dict];
    }];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -
//发布作业
- (void)releaseHomework:(NSDictionary *)dict
{
//    JYXUser *user = [JYXUserManager shareInstance].user;
//    JYXHomeTeacherHomeworkApi *api = [[JYXHomeTeacherHomeworkApi alloc] initWithCourseId:_courseId content:dict[@"content"] type:_type teacherid:user.userId token:user.token pic:dict[@"photos"] prepic:nil];
//    [SVProgressHUD show];
//    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
//        [SVProgressHUD dismiss];
//        NSDictionary *dict = [api fetchDataWithReformer:request];
//        NSLog(@"%@",dict);
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [MBProgressHUD showSuccessMessage:@"发布成功"];
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//
//    } failure:^(__kindof RXBaseRequest *request) {
//        [SVProgressHUD dismiss];
//    }];
    
    [TeacherWorkHandler postWorkWithCourseId:_courseId content:dict[@"content"] type:_type pic:dict[@"photos"] prepare:^{
        
    } success:^(id obj) {
        [MBProgressHUD showSuccessMessage:@"发布成功"];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] init];
        _mScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mScrollView;
}

- (JYXCourseHomeworkContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[JYXCourseHomeworkContentView alloc] init];
    }
    return _contentView;
}

@end
