//
//  JYXSettingViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSettingViewController.h"
#import "JYXSettingTableViewCell.h"
#import "JYXSettingFooterView.h"
#import "JYXCertificationBaseInfoViewController.h"//我要认证
#import "JYXPhoneBindingViewController.h"//手机号绑定
#import "JYXServiceViewController.h"//联系客服
#import "JYXHelpViewController.h"//帮助
#import <SDImageCache.h>
#import "JYXAboutMeViewController.h"


@interface JYXSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation JYXSettingViewController
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
    self.navigationItem.title = NSLocalizedString(@"设置", nil);
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
    NSDictionary *authentication = @{@"title" : @"我要认证", @"type" : @1};
    NSDictionary *phoneBinding = @{@"title" : @"手机号绑定", @"type" : @2};
    NSDictionary *service = @{@"title" : @"联系客服", @"type" : @3};
    NSDictionary *help = @{@"title" : @"帮助", @"type" : @5};
    NSDictionary *aboutUs = @{@"title" : @"关于我们", @"type" : @6};
    NSDictionary *clearCache = @{@"title" : @"清除缓存", @"type" : @7};
//    NSDictionary *checkUpdate = @{@"title" : @"检查更新", @"type" : @8};
    self.dataSourceArray = [@[authentication, phoneBinding, service, help, aboutUs, clearCache] mutableCopy];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *type = self.dataSourceArray[indexPath.row][@"type"];
    switch (type.integerValue) {
        case 1://我要认证
        {
            JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2://手机号绑定
        {
            JYXPhoneBindingViewController *vc = [[JYXPhoneBindingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3://联系客服
        {
            JYXServiceViewController *vc = [[JYXServiceViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5://帮助
        {
            JYXHelpViewController *vc = [[JYXHelpViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6://关于教予学
        {
            JYXAboutMeViewController *vc = [[JYXAboutMeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7://清楚缓存
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [[SDImageCache sharedImageCache] clearMemory];
            });
        }
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXSettingTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXSettingTableViewCell *mCell = (JYXSettingTableViewCell *)cell;
    [mCell configSettingCellWithData:self.dataSourceArray[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    JYXSettingFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYXSettingFooterView class])];
    return footerView;
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionFooterHeight = 61;
        
        [_tableView registerClass:[JYXSettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXSettingTableViewCell class])];
        [_tableView registerClass:[JYXSettingFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYXSettingFooterView class])];
    }
    return _tableView;
}

@end
