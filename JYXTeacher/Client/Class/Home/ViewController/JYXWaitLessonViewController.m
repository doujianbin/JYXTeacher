//
//  JYXWaitLessonViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWaitLessonViewController.h"
#import "JYXWaitLessonTableViewCell.h"
#import "JYXWaitLessonHeaderView.h"
#import "JYXCourseDetailViewController.h"
#import "JYXHomeTeacherWorkListApi.h"
#import "TeacherWorkHandler.h"

@interface JYXWaitLessonViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSDictionary *dataSourceDict;
@property (nonatomic, strong) NSString *currentDateStr;
@end

@implementation JYXWaitLessonViewController
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
    self.page = 1;//默认第一页
    [self loadData];
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
//    self.page = 1;//默认第一页
//    [self loadData];
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
    JYXHomeTeacherWorkListApi *api = [[JYXHomeTeacherWorkListApi alloc] initWithTeacherid:@(user.userId.integerValue) token:user.token type:@1 startime:_currentDateStr page:@1 limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.dataSourceArray removeAllObjects];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        self.dataSourceDict = dict;
        self.dataSourceArray = [dict[@"list"] mutableCopy];
        [self.dataSourceArray addObjectsFromArray:dict[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
    
//    [TeacherWorkHandler teacherWorkListWithStartTime:_currentDateStr page:1 type:1 prepare:^{
//        [SVProgressHUD show];
//    } success:^(id obj) {
//        [SVProgressHUD dismiss];
//        [self.dataSourceArray removeAllObjects];
//        NSDictionary *dict = (NSDictionary *)obj;
////        self.dataSourceDict = dict;
//        //        self.dataSourceArray = [dict[@"list"] mutableCopy];
//        [self.dataSourceArray addObjectsFromArray:dict[@"list"]];
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer resetNoMoreData];
//    } failed:^(NSInteger statusCode, id json) {
//        [SVProgressHUD dismiss];
//        [self.tableView.mj_header endRefreshing];
//    }];
}

- (void)loadMore
{
    self.page++;
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherWorkListApi *api = [[JYXHomeTeacherWorkListApi alloc] initWithTeacherid:@(user.userId.integerValue) token:user.token type:@1 startime:_currentDateStr page:@(self.page) limitnum:@10];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        self.dataSourceDict = dict;
        if ([dict[@"list"] count] > 0) {
            [self.dataSourceArray addObjectsFromArray:dict[@"list"]];
            [self.tableView reloadData];
        }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCourseDetailViewController *vc = [[JYXCourseDetailViewController alloc] init];
    vc.courseType = @0;
    vc.courseId = self.dataSourceArray[indexPath.row][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXWaitLessonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXWaitLessonTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf(weakSelf);
    [cell setDeleteCellBlock:^(NSDictionary *dict) {
        [weakSelf.dataSourceArray removeObject:dict];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXWaitLessonTableViewCell *mCell = (JYXWaitLessonTableViewCell *)cell;
    [mCell configWaitLessonCellWithData:self.dataSourceArray[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYXWaitLessonHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXWaitLessonHeaderView class])];
    WeakSelf(weakSelf);
    [headerView setDateSelectSuccess:^(NSString *selectedDate) {
        weakSelf.currentDateStr = selectedDate;
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    JYXWaitLessonHeaderView *headerView = (JYXWaitLessonHeaderView *)view;
    [headerView configWaitLessonHeaderViewWithData:self.dataSourceDict];
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
        _tableView.rowHeight = 159;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 59;
        _tableView.sectionFooterHeight = 0.01f;
        
        [_tableView registerClass:[JYXWaitLessonHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXWaitLessonHeaderView class])];
        [_tableView registerClass:[JYXWaitLessonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXWaitLessonTableViewCell class])];
    }
    return _tableView;
}

@end
