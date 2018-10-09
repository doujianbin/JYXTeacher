//
//  JYXMyHomeViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyHomeViewController.h"
#import "JYXMyHomeTableViewCell.h"
#import "JYXMyHomeTopBarView.h"
#import "JYXSettingViewController.h"//设置
#import "JYXMyWalletViewController.h"//我的钱包
#import "JYXTakeOrdersSetViewController.h"//接单设置
#import "JYXMyStudentsViewController.h"//我的学生
#import "JYXMyShareViewController.h"//我要共享
#import "JYXMyRankingViewController.h"//我的排名
#import "JYXPlayVedioViewController.h"
#import "TakeOrderSettingHandler.h"
#import "JYXCertificationBaseInfoViewController.h"
#import "JYXCertificationMaterialsViewController.h"

@interface JYXMyHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JYXMyHomeTopBarView *topBarView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) int          teacherStatus;
@end

@implementation JYXMyHomeViewController
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
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.topBarView configMyHomeTopBarViewWithData:@{}];
    [self selectTeacherStatus];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = nil;
    if (IOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.topBarView];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(90+kStatusBarHeight);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topBarView.mas_bottom);
    }];
}

- (void)selectTeacherStatus{
    //查询认证状态  如果没认证  给去认证的提示
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherInfoWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSMutableDictionary *)obj;
        NSLog(@"dic = %@",dic);
        //使用cardname进行资本资料是否填写的判断   其余使用单独字段
        if ([[dic objectForKey:@"cardname"] isEqualToString:@""] || [dic[@"cardstatu"] intValue] == 0 || [dic[@"educationstatu"] intValue] == 0 || [dic[@"senioritystatu"] intValue] == 0) {
            //未认证
            self.teacherStatus = 0;
        }else if (![[dic objectForKey:@"cardname"] isEqualToString:@""] && ([dic[@"cardstatu"] intValue] == 0 || [dic[@"educationstatu"] intValue] == 0 || [dic[@"senioritystatu"] intValue] == 0)){
            //只进行了基本资料认证
            self.teacherStatus = 4;
        }
        else if ([dic[@"cardstatu"] intValue] == 1 || [dic[@"educationstatu"] intValue] == 1 || [dic[@"senioritystatu"] intValue] == 1){
            //认证中
            self.teacherStatus = 1;
        }else if ([dic[@"cardstatu"] intValue] == 3 || [dic[@"educationstatu"] intValue] == 3 || [dic[@"senioritystatu"] intValue] == 3){
            //认证失败
            self.teacherStatus = 2;
        }else{
            //认证通过  接单设置已完成
            self.teacherStatus = 3;
        }
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)loadData
{
    
    NSDictionary *myWallet = @{@"title" : @"我的钱包", @"icon" : [UIImage imageNamed:@"myWallet"], @"type" : @1};
    NSArray *arr1 = @[myWallet];
    
    NSDictionary *takeOrdersSet = @{@"title" : @"接单设置", @"icon" : [UIImage imageNamed:@"takeOrderSet"], @"type" : @2};
    NSDictionary *myStudent = @{@"title" : @"我的学生", @"icon" : [UIImage imageNamed:@"myStudent"], @"type" : @3};
    NSDictionary *myShare = @{@"title" : @"我要共享", @"icon" : [UIImage imageNamed:@"myShare"], @"type" : @4};
    NSDictionary *myRanking = @{@"title" : @"我的排名", @"icon" : [UIImage imageNamed:@"myRanking"], @"type" : @5};
    NSDictionary *useVideo = @{@"title" : @"使用视频", @"icon" : [UIImage imageNamed:@"useVideo"], @"type" : @6};
    NSArray *arr2 = @[takeOrdersSet, myStudent, myShare, myRanking, useVideo];
    
    NSDictionary *setting = @{@"title" : @"设置", @"icon" : [UIImage imageNamed:@"setting"], @"type" : @7};
    NSArray *arr3 = @[setting];
    self.dataSourceArray = [@[arr1, arr2, arr3] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tmpArray = self.dataSourceArray[indexPath.section];
    NSNumber *type = tmpArray[indexPath.row][@"type"];
    switch (type.integerValue) {
        case 1://我的钱包
        {
            JYXMyWalletViewController *vc = [[JYXMyWalletViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2://接单设置
        {
            if (self.teacherStatus == 0 || self.teacherStatus == 2 || self.teacherStatus == 4) {
                //弹窗提示去认证
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (self.teacherStatus == 4) {
                        //跳到基本资料认证
                        //去基本设置界面
                        JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        //跳到资质认证
                        JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [alert addAction:again];
                [self presentViewController:alert animated:YES completion:nil];
            }else if (self.teacherStatus == 1){
                //弹窗提示认证中
                [MBProgressHUD showInfoMessage:@"认证中请耐心等候"];
            }else{
                //跳转界面
                JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 3://我的学生
        {
            if (self.teacherStatus == 0 || self.teacherStatus == 2 || self.teacherStatus == 4) {
                //弹窗提示去认证
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (self.teacherStatus == 4) {
                        //跳到基本资料认证
                        //去基本设置界面
                        JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        //跳到资质认证
                        JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [alert addAction:again];
                [self presentViewController:alert animated:YES completion:nil];
            }else if (self.teacherStatus == 1){
                //弹窗提示认证中
                [MBProgressHUD showInfoMessage:@"认证中请耐心等候"];
            }else{
                //跳转界面
                JYXMyStudentsViewController *vc = [[JYXMyStudentsViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 4://我要共享
        {
            //跳转界面
            JYXMyShareViewController *vc = [[JYXMyShareViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5://我的排名
        {
            JYXMyRankingViewController *vc = [[JYXMyRankingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6://使用视频
        {
            JYXPlayVedioViewController *vc = [[JYXPlayVedioViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7://设置
        {
            JYXSettingViewController *vc = [[JYXSettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXMyHomeTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyHomeTableViewCell *mCell = (JYXMyHomeTableViewCell *)cell;
    [mCell configMyHomeCellWithData:self.dataSourceArray[indexPath.section][indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - getters and setters          - Method -
- (JYXMyHomeTopBarView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[JYXMyHomeTopBarView alloc] init];
    }
    return _topBarView;
}

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
        _tableView.rowHeight = 43;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 15;
        
        [_tableView registerClass:[JYXMyHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXMyHomeTableViewCell class])];
    }
    return _tableView;
}

@end
