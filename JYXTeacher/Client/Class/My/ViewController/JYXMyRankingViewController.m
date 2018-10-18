//
//  JYXMyRankingViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyRankingViewController.h"
#import "JYXMyRankingHeaderView.h"
#import "JYXMyRankingTableViewCell.h"
#import "JYXHomeTeacherTeacherRankingApi.h"

@interface JYXMyRankingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSDictionary *headerMyDataDict;
@end

@implementation JYXMyRankingViewController
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
    self.navigationItem.title = NSLocalizedString(@"综合得分排行榜", nil);
    _page = 1;
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    _page = 1;
    JYXHomeTeacherTeacherRankingApi *api = [[JYXHomeTeacherTeacherRankingApi alloc] initWithTeacherid:user.userId token:user.token page:@"1" limitnum:@"10" cityid:@(user.cityId.integerValue)];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.dataSourceArray removeAllObjects];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        self.headerMyDataDict = dict[@"my"];
        self.dataSourceArray = [dict[@"list"] mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer resetNoMoreData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMore
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    _page ++;
    JYXHomeTeacherTeacherRankingApi *api = [[JYXHomeTeacherTeacherRankingApi alloc] initWithTeacherid:user.userId token:user.token page:@(_page).stringValue limitnum:@"10" cityid:@(user.cityId.integerValue)];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        self.headerMyDataDict = dict[@"my"];
        if ([dict[@"list"] isKindOfClass:[NSArray class]]) {
            [self.dataSourceArray addObjectsFromArray:dict[@"list"]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"list"] count] <= 0) {
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
    JYXMyRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXMyRankingTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyRankingTableViewCell *mCell = (JYXMyRankingTableViewCell *)cell;
    [mCell configMyRankingCellWithData:self.dataSourceArray[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYXMyRankingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXMyRankingHeaderView class])];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    JYXMyRankingHeaderView *headerView = (JYXMyRankingHeaderView *)view;
    [headerView configMyRankingHeaderViewWithData:self.headerMyDataDict];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

#pragma mark - getters and setters          - Method -
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 87;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 143;
        _tableView.sectionFooterHeight = 0.001f;
        
        [_tableView registerClass:[JYXMyRankingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXMyRankingTableViewCell class])];
        [_tableView registerClass:[JYXMyRankingHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXMyRankingHeaderView class])];
    }
    return _tableView;
}

@end
