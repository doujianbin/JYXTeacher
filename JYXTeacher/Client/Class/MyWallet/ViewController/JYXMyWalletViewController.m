//
//  JYXMyWalletViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyWalletViewController.h"
#import "JYXMyWalletTableViewCell.h"
#import "JYXMyWalletHeaderView.h"
#import "JYXAccountManageViewController.h"//账户管理
#import "JYXShareEarningsViewController.h"//共享收益
#import "JYXClassFeeViewController.h"//课时费
#import "JYXMyWelfareViewController.h"//我的福利
#import "JYXHomeTeacherTeacherPurseApi.h"

@interface JYXMyWalletViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSDictionary *headerDataDict;
@end

@implementation JYXMyWalletViewController
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
    self.navigationItem.title = NSLocalizedString(@"我的钱包", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    NSDictionary *accountManagement = @{@"title" : @"账户管理", @"icon" : [UIImage imageNamed:@"accountManagement"], @"type" : @1};
    NSDictionary *shareEarnings = @{@"title" : @"共享收益", @"icon" : [UIImage imageNamed:@"shareEarnings"], @"type" : @2};
    NSDictionary *myWelfare = @{@"title" : @"我的福利", @"icon" : [UIImage imageNamed:@"fuli"], @"type" : @3};
    NSDictionary *classFee = @{@"title" : @"课时费", @"icon" : [UIImage imageNamed:@"classFee"], @"type" : @4};
    self.dataSourceArray = [@[accountManagement, shareEarnings, myWelfare, classFee] mutableCopy];
    [self.tableView reloadData];
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherPurseApi *api = [[JYXHomeTeacherTeacherPurseApi alloc] initWithUserid:user.userId WithToken:user.token];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        self.headerDataDict = dict;
        [self.tableView reloadData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSourceArray[indexPath.row];
    NSNumber *type = dict[@"type"];
    switch (type.integerValue) {
        case 1://账户管理
        {
            JYXAccountManageViewController *vc = [[JYXAccountManageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2://共享收益
        {
            JYXShareEarningsViewController *vc = [[JYXShareEarningsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3://我的福利
        {
            JYXMyWelfareViewController *vc = [[JYXMyWelfareViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4://课时费
        {
            JYXClassFeeViewController *vc = [[JYXClassFeeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXMyWalletTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyWalletTableViewCell *mCell = (JYXMyWalletTableViewCell *)cell;
    [mCell configMyWalletCellWithData:self.dataSourceArray[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYXMyWalletHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXMyWalletHeaderView class])];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    JYXMyWalletHeaderView *headerView = (JYXMyWalletHeaderView *)view;
    [headerView configMyWalletHeaderViewWithData:self.headerDataDict];
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
        _tableView.rowHeight = 43;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 242;
        _tableView.sectionFooterHeight = 0.01f;
        _tableView.contentInset = EdgeInsets(0.5, 0, 0, 0);
        
        [_tableView registerClass:[JYXMyWalletHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXMyWalletHeaderView class])];
        [_tableView registerClass:[JYXMyWalletTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXMyWalletTableViewCell class])];
    }
    return _tableView;
}

@end
