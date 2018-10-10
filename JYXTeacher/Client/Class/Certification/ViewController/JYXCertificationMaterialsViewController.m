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
    
    UILabel *lb_detail = [[UILabel alloc]init];
    [self.view addSubview:lb_detail];
    [lb_detail setText:@"*教予学平台每年对教师信息进行随机抽查审核，若未通过审查，则平台有权冻结您的账户以及相关福利保障。情节严重者，交由国家相关部门进行处理。"];
    [lb_detail setTextColor:[UIColor colorWithHexString:@"#1AABFD"]];
    lb_detail.font = [UIFont systemFontOfSize:14];
    lb_detail.numberOfLines = 0;
    [lb_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-30);
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
    NSDictionary *aptitude = @{@"title":@"资质认证", @"type":@4, @"status":senioritystatu};
    NSDictionary *major = @{@"title":@"专业认证", @"type":@5, @"status":@""};
    self.dataSourceArray = [@[teacherType, IDcard, education, aptitude, major] mutableCopy];
}

#pragma mark - eventResponse                - Method -
//提交资料
- (void)submitAction:(UIButton *)sender
{
    NSDictionary *dic_teacherType = [self.dataSourceArray objectAtIndex:0];
    NSDictionary *dic_card = [self.dataSourceArray objectAtIndex:1];
    NSDictionary *dic_stu = [self.dataSourceArray objectAtIndex:2];
    if ([[dic_teacherType objectForKey:@"status"] isEqualToString:@"全职教师"] || [[dic_teacherType objectForKey:@"status"] isEqualToString:@"大学生"] || [[dic_teacherType objectForKey:@"status"] isEqualToString:@"自由教师"]) {
        if ([[dic_card objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_card objectForKey:@"status"] isEqualToString:@"未通过"]) {
            [MBProgressHUD showInfoMessage:@"请上传身份证照片"];
            return;
        }
        if ([[dic_stu objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_stu objectForKey:@"status"] isEqualToString:@"未通过"]) {
            [MBProgressHUD showInfoMessage:@"请上传学历认证照片"];
            return;
        }
    }
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherTeacherEditApi *api = [[JYXHomeTeacherTeacherEditApi alloc] initWithUserid:user.userId token:user.token cardname:user.cardname teachertype:[dic_teacherType objectForKey:@"status"]];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSNumber *isSuccess = [api fetchDataWithReformer:request];
        if (isSuccess.boolValue) {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [WLToast show:@"提交成功！"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -
- (void)naviBack:(UIButton *)btn{
    NSDictionary *dic_teacherType = [self.dataSourceArray objectAtIndex:0];
    NSDictionary *dic_card = [self.dataSourceArray objectAtIndex:1];
    NSDictionary *dic_stu = [self.dataSourceArray objectAtIndex:2];
    NSDictionary *dic_zizhi = [self.dataSourceArray objectAtIndex:3];
    if ([[dic_teacherType objectForKey:@"status"] isEqualToString:@"全职教师"]) {
        if ([[dic_card objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_card objectForKey:@"status"] isEqualToString:@"未通过"]) {

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您选择的是全职教师" message:@"请完成身份认证" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"现在认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:cancel];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if ([[dic_stu objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_stu objectForKey:@"status"] isEqualToString:@"未通过"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您选择的是全职教师" message:@"请完成学历认证" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"现在认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:cancel];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    if ([[dic_teacherType objectForKey:@"status"] isEqualToString:@"大学生"]|| [[dic_teacherType objectForKey:@"status"] isEqualToString:@"自由教师"]) {
        NSString *str_teacherType = [dic_teacherType objectForKey:@"status"];
        if ([[dic_card objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_card objectForKey:@"status"] isEqualToString:@"未通过"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您选择的是%@",str_teacherType] message:@"请完成身份认证" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"现在认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:cancel];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if ([[dic_stu objectForKey:@"status"] isEqualToString:@"未认证"] || [[dic_stu objectForKey:@"status"] isEqualToString:@"未通过"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您选择的是%@",str_teacherType] message:@"请完成学历认证" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"现在认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:cancel];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
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
                        if ([[teacherType objectForKey:@"status"] isEqualToString:@"大学生"] || [[teacherType objectForKey:@"status"] isEqualToString:@"自由教师"]) {
                            NSDictionary *dic_data = [self.dataSourceArray objectAtIndex:3];
                            NSDictionary *zizhiType = @{@"title":@"资质认证", @"type":@4, @"status":[dic_data objectForKey:@"status"]};
                            [weakSelf.dataSourceArray replaceObjectAtIndex:3 withObject:zizhiType];
                        }else{
                            NSDictionary *dic_data = [self.dataSourceArray objectAtIndex:3];
                            NSDictionary *zizhiType = @{@"title":@"资质认证", @"type":@4, @"status":[dic_data objectForKey:@"status"]};
                            [weakSelf.dataSourceArray replaceObjectAtIndex:3 withObject:zizhiType];
                        }
                        [weakSelf.tableView reloadData];
                        [weakPopView dismiss];
                    };
                }
            }];
        }
            break;
        case 2://身份认证
        {
            if ([user.cardstatu integerValue] == 1 ||[user.cardstatu integerValue] == 2) {
                return;
            }
            [[NSUserDefaults standardUserDefaults] setValue:[[self.dataSourceArray objectAtIndex:0] objectForKey:@"status"] forKey:@"teacherType"];
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
            if ([user.educationstatu integerValue] == 1 || [user.educationstatu integerValue] == 2) {
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
            if ([user.senioritystatu integerValue] == 1 || [user.senioritystatu integerValue] == 2) {
                return;
            }
            [[YXGShowPopAnimationView sharedInstance] showPopAnimationWithView:[[JYXAptitudeApproveView alloc] init] withPopStyle:ZJAnimationPopStyleScale withDismissStyle:ZJAnimationDismissStyleScale withHandleAction:^(ZJAnimationPopView *popView, id customView) {
                // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
                __weak typeof(popView) weakPopView = popView;
                if ([customView isKindOfClass:[JYXAptitudeApproveView class]]) {
                    JYXAptitudeApproveView *alertView = customView;
                    WeakSelf(weakSelf);
                    [alertView setSubmitSuccessBlock:^{
                        NSDictionary *teacherType = @{@"title":@"资质认证", @"type":@4, @"status":@"认证中"};
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
    
    NSString *msg = @"大学生：拥有从事教育培训工作能力且学籍正常的在校大学生。\n\n自由教师：自由从事教育工作的家教、退休教师或正在从事其他行业但有能力兼职教育培训工作的人群（必须为毕业生）。\n\n全职教师：专业从事教育行业工作的在职教师（如：公立或私立学校的在职教师或教育机构的在职教师等）；全职教师必须有相关工作证明（如：单位开具的工作证明、工作证或工牌等能证明身份的证明）。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"教师类型" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIView *subView1 = alert.view.subviews[0];
    
    UIView *subView2 = subView1.subviews[0];
    
    UIView *subView3 = subView2.subviews[0];
    
    UIView *subView4 = subView3.subviews[0];
    
    UIView *subView5 = subView4.subviews[0];
        
    UILabel *message = subView5.subviews[2];
    
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
