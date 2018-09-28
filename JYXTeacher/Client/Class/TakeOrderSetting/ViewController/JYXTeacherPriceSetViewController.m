//
//  JYXTeacherPriceSetViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTeacherPriceSetViewController.h"
#import "JYXTeacherPriceSetTableViewCell.h"
#import "JYXTeacherPriceSetFooterView.h"
#import "JYXChangeTeacherPriceViewController.h"

@interface JYXTeacherPriceSetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation JYXTeacherPriceSetViewController
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
    self.navigationItem.title = NSLocalizedString(@"推荐名师预设价格", nil);
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
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSDictionary *oneDict = @{@"title":@"一年级",@"price":user.citypriceone?:@"0",@"id":@"1"};
    NSDictionary *twoDict = @{@"title":@"二年级",@"price":user.citypricetwo?:@"0",@"id":@"2"};
    NSDictionary *threeDict = @{@"title":@"三年级",@"price":user.citypricethree?:@"0",@"id":@"3"};
    NSDictionary *fourDict = @{@"title":@"四年级",@"price":user.citypricefour?:@"0",@"id":@"4"};
    NSDictionary *fiveDict = @{@"title":@"五年级",@"price":user.citypricefive?:@"0",@"id":@"5"};
    NSDictionary *sixDict = @{@"title":@"六年级",@"price":user.citypricesix?:@"0",@"id":@"6"};
    NSDictionary *sevenDict = @{@"title":@"初一",@"price":user.citypriceseven?:@"0",@"id":@"7"};
    NSDictionary *eightDict = @{@"title":@"初二",@"price":user.citypriceeight?:@"0",@"id":@"8"};
    NSDictionary *nineDict = @{@"title":@"初三",@"price":user.citypricenine?:@"0",@"id":@"9"};
    NSDictionary *tenDict = @{@"title":@"高一",@"price":user.citypriceten?:@"0",@"id":@"10"};
    NSDictionary *elevenDict = @{@"title":@"高二",@"price":user.citypriceeleven?:@"0",@"id":@"11"};
    NSDictionary *twelveDict = @{@"title":@"高三",@"price":user.citypricetwelve?:@"0",@"id":@"12"};
    self.dataSourceArray = [@[oneDict, twoDict, threeDict, fourDict, fiveDict, sixDict, sevenDict, eightDict, nineDict, tenDict, elevenDict, twelveDict] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXChangeTeacherPriceViewController *vc = [[JYXChangeTeacherPriceViewController alloc] init];
    [vc setResult:self.dataSourceArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTeacherPriceSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXTeacherPriceSetTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configTeacherPriceSetCellWithData:self.dataSourceArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    JYXTeacherPriceSetFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXTeacherPriceSetFooterView class])];
    [footerView configTeacherPriceSetFooterViewWithData:@{}];
    return footerView;
}

#pragma mark - getters and setters          - Method -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.001f;
        _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionFooterHeight = 200;
        
        [_tableView registerClass:[JYXTeacherPriceSetTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXTeacherPriceSetTableViewCell class])];
        [_tableView registerClass:[JYXTeacherPriceSetFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXTeacherPriceSetFooterView class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

@end
