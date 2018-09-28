//
//  JYXScheduleViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXScheduleViewController.h"
#import "JYXScheduleTopBarView.h"
#import "JYXScheduleTableViewCell.h"
#import "JYXHomeTeacherTeacherClassesApi.h"

@interface JYXScheduleViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *yearStr;
@property (nonatomic, strong) NSString *monthStr;
@property (nonatomic, strong) JYXScheduleTopBarView *topBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation JYXScheduleViewController
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
    self.navigationItem.title = NSLocalizedString(@"总课表", nil);
    self.page = 1;
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.topBgView];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(1);
        make.height.offset(94);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topBgView.mas_bottom).offset(4);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    WeakSelf(weakSelf);
    [self.topBgView setYearBlock:^(NSString *year) {
        weakSelf.yearStr = year;
        [weakSelf loadData];
    }];
    
    [self.topBgView setMonthBlock:^(NSString *month) {
        weakSelf.monthStr = month;
        [weakSelf loadData];
    }];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherClassesApi *api = [[JYXHomeTeacherTeacherClassesApi alloc] initWithUserid:user.userId WithToken:user.token year:self.yearStr mouth:self.monthStr page:@1 limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.dataSourceArray removeAllObjects];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [self.dataSourceArray removeAllObjects];
        [self.topBgView configScheduleViewWithData:dict[@"info"]];
        self.dataSourceArray = [dict[@"classes"] mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMore
{
    self.page++;
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherClassesApi *api = [[JYXHomeTeacherTeacherClassesApi alloc] initWithUserid:user.userId WithToken:user.token year:self.yearStr mouth:self.monthStr page:@(self.page) limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [self.topBgView configScheduleViewWithData:dict[@"info"]];
        [self.dataSourceArray addObjectsFromArray:dict[@"classes"]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"classes"] count] <= 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXScheduleTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configScheduleCellWithData:@{@"index":@(indexPath.row), @"total":@(self.dataSourceArray.count),@"data":self.dataSourceArray[indexPath.row]}];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

#pragma mark - getters and setters          - Method -
- (JYXScheduleTopBarView *)topBgView
{
    if (!_topBgView) {
        _topBgView = [[JYXScheduleTopBarView alloc] init];
    }
    return _topBgView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        
        [_tableView registerClass:[JYXScheduleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXScheduleTableViewCell class])];
    }
    return _tableView;
}

@end
