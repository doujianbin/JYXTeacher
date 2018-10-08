//
//  JYXTakeOrdersSetViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTakeOrdersSetViewController.h"
#import "JYXTakeOrdersSetTableViewCell.h"
#import "JYXTakeOrdersSetHeaderView.h"
#import "JYXLessonDateViewController.h"//计划授课时间
#import "JYXTeachingMethodViewController.h"//授课方式设置
#import "JYXLessonDistanceViewController.h"//授课距离设置
#import "JYXAddressManageViewController.h"//地址管理
#import "JYXTeacherPriceSetViewController.h"//推荐名师预设价格
#import "JYXHomeTeacherSetupApi.h"//接单设置
#import "JYXHomeGetTeacherInfoApi.h"
#import "TakeOrderSettingHandler.h"
#import "JYXWebViewViewController.h"

@interface JYXTakeOrdersSetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger currentRange;//当前设置的授课距离
@property (nonatomic, strong) JYXTakeOrdersSetHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic ,strong) NSMutableDictionary *dic_data;

@end

@implementation JYXTakeOrdersSetViewController
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
    self.navigationItem.title = NSLocalizedString(@"接单设置", nil);
    [self setRightBarButton];
    [self loadData];
}

- (void)setRightBarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:NSLocalizedString(@"基本服务准则", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(13);
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
//    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
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
    NSDictionary *teachingTime = @{@"title":@"计划授课时间", @"type":@1,@"detailTitle":@""};
    NSDictionary *teachingType = @{@"title":@"授课方式设置", @"type":@2,@"detailTitle":@""};
    NSDictionary *teachingDistance = @{@"title":@"授课距离设置", @"type":@3,@"detailTitle":@""};
    NSDictionary *recommendTeacher = @{@"title":@"推荐名师预设价格", @"type":@5,@"detailTitle":@"*未预设推荐名师预设价格则按照平台价格的1.5倍执行。"};
    self.dataSourceArray = [@[teachingTime, teachingType, teachingDistance, recommendTeacher] mutableCopy];
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherInfoWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        self.dic_data = (NSMutableDictionary *)obj;
        [user clear];
        [user configUserData:self.dic_data];
        self.currentRange = [[self.dic_data objectForKey:@"range"] integerValue];
        [self.headerView.collectionView reloadData];
        NSArray *arr_grade = [NSArray arrayWithArray:[self.dic_data objectForKey:@"gradesubject"]];
        NSLog(@"arr_grade = %@",arr_grade);
        NSMutableArray *arr_data = [NSMutableArray array];
        for (NSDictionary *dic in arr_grade) {
            for (NSDictionary *dic2 in [dic objectForKey:@"value"]) {
                [arr_data addObject:[NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"name"],[dic2 objectForKey:@"name"]]];
            }
        }
        NSLog(@"arr_data == %@",arr_data);
        [self.headerView contentCellWithDataArr:arr_data];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

- (void)rightBarAction{
    JYXWebViewViewController *vc = [[JYXWebViewViewController alloc]init];
    vc.str_title = @"基本服务准则";
    vc.str_url = [NSString stringWithFormat:@"%@API_DOC/help/service.html",API_Login];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 65;
    }else{
        return 45;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *type = self.dataSourceArray[indexPath.row][@"type"];
    switch (type.integerValue) {
        case 1://计划授课时间
        {
            JYXLessonDateViewController *vc = [[JYXLessonDateViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2://授课方式设置
        {
            JYXTeachingMethodViewController *vc = [[JYXTeachingMethodViewController alloc] init];
            vc.dic_data = self.dic_data;
            [self.navigationController pushViewController:vc animated:YES];
            vc.teacherClassComplete = ^{
                [self loadData];
            };
        }
            break;
        case 3://授课距离设置
        {
            JYXLessonDistanceViewController *vc = [[JYXLessonDistanceViewController alloc] init];
            WeakSelf(weakSelf);
            [vc setLessonDistanceBlock:^(NSInteger range) {
                weakSelf.currentRange = range;
                [self loadData];
            }];
            vc.currentDistance = self.currentRange;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5://推荐名师预设价格
        {
            JYXTeacherPriceSetViewController *vc = [[JYXTeacherPriceSetViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTakeOrdersSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXTakeOrdersSetTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTakeOrdersSetTableViewCell *mCell = (JYXTakeOrdersSetTableViewCell *)cell;
    [mCell configTakeOrdersSetCellWithData:self.dataSourceArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYXTakeOrdersSetHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXTakeOrdersSetHeaderView class])];
    self.headerView = headerView;
    [headerView configTakeOrdersSetHeaderView];
    return headerView;
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
//        _tableView.rowHeight = 45;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 205;
        
        [_tableView registerClass:[JYXTakeOrdersSetTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXTakeOrdersSetTableViewCell class])];
        [_tableView registerClass:[JYXTakeOrdersSetHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXTakeOrdersSetHeaderView class])];
    }
    return _tableView;
}

@end
