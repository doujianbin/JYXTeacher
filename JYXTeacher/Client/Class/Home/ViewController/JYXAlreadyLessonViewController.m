//
//  JYXAlreadyLessonViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAlreadyLessonViewController.h"
#import "JYXAlreadyLessonTableViewCell.h"
#import "JYXCourseDetailViewController.h"
#import "JYXHomeTeacherWorkListApi.h"

@interface JYXAlreadyLessonViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation JYXAlreadyLessonViewController
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
    self.page = 1;//默认第一页
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)loadData
{
    self.page = 1;
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherWorkListApi *api = [[JYXHomeTeacherWorkListApi alloc] initWithTeacherid:@(user.userId.integerValue) token:user.token type:@2 startime:nil page:@1 limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        self.dataSourceArray = [array mutableCopy];
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
    JYXHomeTeacherWorkListApi *api = [[JYXHomeTeacherWorkListApi alloc] initWithTeacherid:@(user.userId.integerValue) token:user.token type:@2 startime:nil page:@(self.page) limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        [self.dataSourceArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if ([array count] <= 0) {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCourseDetailViewController *vc = [[JYXCourseDetailViewController alloc] init];
    vc.courseType = @1;
    vc.courseId = self.dataSourceArray[indexPath.row][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAlreadyLessonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXAlreadyLessonTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAlreadyLessonTableViewCell *mCell = (JYXAlreadyLessonTableViewCell *)cell;
    [mCell configAlreadyLessonCellWithData:self.dataSourceArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
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
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 159;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = EdgeInsets(4, 0, 0, 0);
        
        [_tableView registerClass:[JYXAlreadyLessonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXAlreadyLessonTableViewCell class])];
    }
    return _tableView;
}

@end
