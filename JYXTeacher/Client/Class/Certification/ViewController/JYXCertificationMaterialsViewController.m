//
//  JYXCertificationMaterialsViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCertificationMaterialsViewController.h"
#import "JYXCertificationMaterialsTableViewCell.h"
#import "JYXTeacherTypeView.h"
#import "JYXIDcardApproveView.h"
#import "JYXEducationApproveView.h"
#import "JYXAptitudeApproveView.h"
#import "JYXSpecialtyApproveViewController.h"
#import "JYXHomeTeacherTeacherEditApi.h"
#import "JYXCertificationBaseInfoViewController.h"

@interface JYXCertificationMaterialsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSString *currentTeacherType;


@end

@implementation JYXCertificationMaterialsViewController
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
    self.navigationItem.title = NSLocalizedString(@"资料认证", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.height.offset(35);
        make.top.equalTo(self.tableView.mas_bottom).offset(30);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSString *cardstatu = @"";
    //身份验证状态0未认证1认证中2已通过3未通过
    switch (user.cardstatu.integerValue) {
        case 0:
        {
            cardstatu = NSLocalizedString(@"未认证", nil);
        }
            break;
        case 1:
        {
            cardstatu = NSLocalizedString(@"认证中", nil);
        }
            break;
        case 2:
        {
            cardstatu = NSLocalizedString(@"已通过", nil);
        }
            break;
        case 3:
        {
            cardstatu = NSLocalizedString(@"未通过", nil);
        }
            break;
        default:
            break;
    }
    NSString *educationstatu = @"";
    //学历认证状态0未认证1认证中2已通过3未通过
    switch (user.educationstatu.integerValue) {
        case 0:
        {
            educationstatu = NSLocalizedString(@"未认证", nil);
        }
            break;
        case 1:
        {
            educationstatu = NSLocalizedString(@"认证中", nil);
        }
            break;
        case 2:
        {
            educationstatu = NSLocalizedString(@"已通过", nil);
        }
            break;
        case 3:
        {
            educationstatu = NSLocalizedString(@"未通过", nil);
        }
            break;
        default:
            break;
    }
    NSString *senioritystatu = @"";
    //教师资格认证状态0未认证1认证中2已通过3未通过
    switch (user.senioritystatu.integerValue) {
        case 0:
        {
            senioritystatu = NSLocalizedString(@"未认证", nil);
        }
            break;
        case 1:
        {
            senioritystatu = NSLocalizedString(@"认证中", nil);
        }
            break;
        case 2:
        {
            senioritystatu = NSLocalizedString(@"已通过", nil);
        }
            break;
        case 3:
        {
            senioritystatu = NSLocalizedString(@"未通过", nil);
        }
            break;
        default:
            break;
    }
    NSDictionary *teacherType = @{@"title":@"教师类型（必填）", @"type":@1, @"status":user.teachertype?:@""};
    NSDictionary *IDcard = @{@"title":@"身份认证（必填）", @"type":@2, @"status":cardstatu};
    NSDictionary *education = @{@"title":@"学历认证（必填）", @"type":@3, @"status":educationstatu};
    NSDictionary *aptitude = @{@"title":@"资质认证（必填）", @"type":@4, @"status":senioritystatu};
    NSDictionary *major = @{@"title":@"专业认证", @"type":@5, @"status":@""};
    self.dataSourceArray = [@[teacherType, IDcard, education, aptitude, major] mutableCopy];
}

#pragma mark - eventResponse                - Method -
//提交资料
- (void)submitAction:(UIButton *)sender
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname teachertype:_currentTeacherType];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            [WLToast show:@"提交成功！"];
//            NSArray *arr_vc = self.navigationController.viewControllers;
//            for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
//                UIViewController *vc = [arr_vc objectAtIndex:index];
//                if (![vc isKindOfClass:[JYXCertificationMaterialsViewController class]] && ![vc isKindOfClass:[JYXCertificationBaseInfoViewController class]]) {
//                    [self.navigationController popToViewController:vc animated:YES];
//                    return;
//                }
//            }
            [self.navigationController popToRootViewControllerAnimated:YES];
//            WeakSelf(weakSelf);
//            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
//            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                [weakSelf.navigationController.tabBarController setSelectedIndex:0];
//            });

        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *type = self.dataSourceArray[indexPath.row][@"type"];
    JYXUser *user = [JYXUserManager shareInstance].user;
    switch (type.integerValue) {
        case 1://教师类型
        {
            [[YXGShowPopAnimationView sharedInstance] showPopAnimationWithView:[[JYXTeacherTypeView alloc] init] withPopStyle:ZJAnimationPopStyleScale withDismissStyle:ZJAnimationDismissStyleScale withHandleAction:^(ZJAnimationPopView *popView, id customView) {
                // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
                __weak typeof(popView) weakPopView = popView;
                if ([customView isKindOfClass:[JYXTeacherTypeView class]]) {
                    JYXTeacherTypeView *alertView = customView;
                    WeakSelf(weakSelf);
                    alertView.teacherTypeBlock = ^(NSString *type) {
                        weakSelf.currentTeacherType = type;
                        NSDictionary *teacherType = @{@"title":@"教师类型（必填）", @"type":@1, @"status":type};
                        [weakSelf.dataSourceArray replaceObjectAtIndex:0 withObject:teacherType];
                        [weakSelf.tableView reloadData];
                        [weakPopView dismiss];
                    };
                }
            }];
        }
            break;
        case 2://身份认证
        {
            if ([user.cardstatu integerValue] == 2) {
                return;
            }
            [[YXGShowPopAnimationView sharedInstance] showPopAnimationWithView:[[JYXIDcardApproveView alloc] init] withPopStyle:ZJAnimationPopStyleScale withDismissStyle:ZJAnimationDismissStyleScale withHandleAction:^(ZJAnimationPopView *popView, id customView) {
                // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
                __weak typeof(popView) weakPopView = popView;
                if ([customView isKindOfClass:[JYXIDcardApproveView class]]) {
                    JYXIDcardApproveView *alertView = customView;
                    WeakSelf(weakSelf);
                    [alertView setSubmitSuccessBlock:^{
                        NSDictionary *teacherType = @{@"title":@"身份认证（必填）", @"type":@2, @"status":@"认证中"};
                        [weakSelf.dataSourceArray replaceObjectAtIndex:1 withObject:teacherType];
                        [weakSelf.tableView reloadData];
                        [weakPopView dismiss];
                    }];
                }
            }];
        }
            break;
        case 3://学历认证
        {
            if ([user.educationstatu integerValue] == 2) {
                return;
            }
            [[YXGShowPopAnimationView sharedInstance] showPopAnimationWithView:[[JYXEducationApproveView alloc] init] withPopStyle:ZJAnimationPopStyleScale withDismissStyle:ZJAnimationDismissStyleScale withHandleAction:^(ZJAnimationPopView *popView, id customView) {
                // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
                __weak typeof(popView) weakPopView = popView;
                if ([customView isKindOfClass:[JYXEducationApproveView class]]) {
                    JYXEducationApproveView *alertView = customView;
                    WeakSelf(weakSelf);
                    [alertView setSubmitSuccessBlock:^{
                        NSDictionary *teacherType = @{@"title":@"学历认证（必填）", @"type":@3, @"status":@"认证中"};
                        [weakSelf.dataSourceArray replaceObjectAtIndex:2 withObject:teacherType];
                        [weakSelf.tableView reloadData];
                        [weakPopView dismiss];
                    }];
                }
            }];
        }
            break;
        case 4://资质认证认证
        {
            if ([user.senioritystatu integerValue] == 2) {
                return;
            }
            [[YXGShowPopAnimationView sharedInstance] showPopAnimationWithView:[[JYXAptitudeApproveView alloc] init] withPopStyle:ZJAnimationPopStyleScale withDismissStyle:ZJAnimationDismissStyleScale withHandleAction:^(ZJAnimationPopView *popView, id customView) {
                // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
                __weak typeof(popView) weakPopView = popView;
                if ([customView isKindOfClass:[JYXAptitudeApproveView class]]) {
                    JYXAptitudeApproveView *alertView = customView;
                    WeakSelf(weakSelf);
                    [alertView setSubmitSuccessBlock:^{
                        NSDictionary *teacherType = @{@"title":@"资质认证（必填）", @"type":@4, @"status":@"认证中"};
                        [weakSelf.dataSourceArray replaceObjectAtIndex:3 withObject:teacherType];
                        [weakSelf.tableView reloadData];
                        [weakPopView dismiss];
                    }];
                }
            }];
        }
            break;
        case 5://专业认证
        {
            JYXSpecialtyApproveViewController *vc = [[JYXSpecialtyApproveViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCertificationMaterialsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXCertificationMaterialsTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.helpImg addTarget:self action:@selector(helpImgAction) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCertificationMaterialsTableViewCell *mCell = (JYXCertificationMaterialsTableViewCell *)cell;
    [mCell configCertificationMaterialsCellWithData:self.dataSourceArray[indexPath.row]];
}

- (void)helpImgAction{
    
    NSString *msg = @"1、大学生：\n身份认证：上传身份证\n学历认证：上传学生证/校园卡（可辅助认证）\n专业认证：上传相关专业证明\n资质认证：上传教师资格证、职称等\n2、自由教师：\n身份认证：上传身份证、工作相关证明（可辅助认证）\n学历认证：上传毕业证\n专业认证：上传相关专业证明\n资质认证：上传教师资格证、职称等\n3、全职教师：\n身份认证：上传身份证、工作相关证明（可辅助认证）\n学历认证：上传毕业证\n专业认证：上传相关专业证明\n资质认证：上传教师资格证、职称等\n4、如实填写相关信息，提交相关认证，有助于提高您的信誉度，得到学生信赖，获得更多课程订单。\n5、教予学平台每年对教师信息进行随机抽查审核，若未通过审查，则平台有权冻结您的账户以及相关福利保障。情节严重者，交由国家相关部门进行处理。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"教师类型" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIView *subView1 = alert.view.subviews[0];
    
    UIView *subView2 = subView1.subviews[0];
    
    UIView *subView3 = subView2.subviews[0];
    
    UIView *subView4 = subView3.subviews[0];
    
    UIView *subView5 = subView4.subviews[0];
        
    UILabel *message = subView5.subviews[1];
    
    message.textAlignment = NSTextAlignmentLeft;
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

#pragma mark - getters and setters          - Method -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 45;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = EdgeInsets(8, 0, 0, 0);
        
        [_tableView registerClass:[JYXCertificationMaterialsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXCertificationMaterialsTableViewCell class])];
    }
    return _tableView;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_SIZE(15);
        _submitBtn.layer.cornerRadius = 18;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
