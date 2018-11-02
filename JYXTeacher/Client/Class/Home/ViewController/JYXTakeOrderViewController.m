//
//  JYXTakeOrderViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTakeOrderViewController.h"
#import "JYXTakeOrderTableViewCell.h"
#import "JYXCourseDetailViewController.h"
#import "JYXHomeTeacherSearchListApi.h"
#import "TakeOrderSettingHandler.h"
#import "JYXCertificationBaseInfoViewController.h"
#import "JYXCertificationMaterialsViewController.h"
#import "JYXTakeOrdersSetViewController.h"
#import "ScottPageView.h"
#import "JYXShareWebViewViewController.h"

@interface JYXTakeOrderViewController ()<UITableViewDataSource, UITableViewDelegate,BaseTableViewDelagate>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSDictionary *dic_teacherInfo;
@property (nonatomic ,strong) UIView   *v_back;
@property (nonatomic ,strong) UIButton   *btn_action;
@property (nonatomic ,strong) UILabel    *lb_detail;
@property (nonatomic ,strong) UILabel    *lb_noData;
@property (nonatomic, assign) int            teacherStatus;
@property (nonatomic, strong) ScottPageView *pageViewCode;
@property (nonatomic, strong) NSMutableArray *picArrs;
@property (nonatomic, strong) NSMutableArray *adArrs;
//teacherStatus 0：新账户 1：只进行基本资料认证  2：资质认证通过 3.认证中 4.认证失败 5.接单设置完成（可操作账户）
@end

@implementation JYXTakeOrderViewController
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
    [self selectTeacherStatus];
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
    self.picArrs = [[NSMutableArray alloc]init];
    self.adArrs = [[NSMutableArray alloc]init];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.v_back = [[UIView alloc]initWithFrame:self.tableView.frame];
    [self.v_back setBackgroundColor:[UIColor clearColor]];
    
    self.btn_action = [[UIButton alloc]init];
    [self.v_back addSubview:self.btn_action];
    [self.btn_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_back);
        make.centerY.equalTo(self.v_back).offset(-45);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(35);
    }];
    self.btn_action.backgroundColor = [UIColor colorWithHexString:@"#1AABFD"];
    self.btn_action.layer.cornerRadius = 18;
    self.btn_action.layer.masksToBounds = YES;
    self.btn_action.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_action addTarget:self action:@selector(btn_actionAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.lb_detail = [[UILabel alloc]init];
    [self.v_back addSubview:self.lb_detail];
    [self.lb_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn_action.mas_bottom).offset(8);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(40);
    }];
    [self.lb_detail setTextColor:[UIColor colorWithHexString:@"#6D6D6D"]];
    self.lb_detail.font = [UIFont systemFontOfSize:11];
    [self.lb_detail setTextAlignment:NSTextAlignmentCenter];
    self.lb_detail.numberOfLines = 0;
    
    self.lb_noData = [[UILabel alloc]initWithFrame:self.tableView.frame];
    [self.lb_noData setText:@"暂无数据"];
    [self.lb_noData setTextColor:[UIColor colorWithHexString:@"#6D6D6D"]];
    self.lb_noData.font = [UIFont systemFontOfSize:17];
    [self.lb_noData setTextAlignment:NSTextAlignmentCenter];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

- (void)selectTeacherStatus{
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherInfoWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        //先判断是否进行资质认证  认证通过后才可以进行接单设置
        JYXUser *user = [JYXUserManager shareInstance].user;
        NSDictionary *dic = (NSMutableDictionary *)obj;
        NSLog(@"dic = %@",dic);
        self.dic_teacherInfo = dic;
        [self.adArrs removeAllObjects];
        [self.picArrs removeAllObjects];
        [self.adArrs addObjectsFromArray:[dic objectForKey:@"ad"]];
        for (int i = 0; i < self.adArrs.count; i++) {
            [self.picArrs addObject:[[self.adArrs objectAtIndex:i] objectForKey:@"pic"]];
        }
        //使用cardname进行资本资料是否填写的判断   其余使用单独字段
        //认证状态
        if ([user.cardname isEqualToString:@""]) {
            self.teacherStatus = 0;
        }else{
            if ([user.teachertype isEqualToString:@"全职教师"] || [user.teachertype isEqualToString:@"大学生"] || [user.teachertype isEqualToString:@"自由教师"]) {
                if ([user.cardstatu intValue] == 2 && [user.educationstatu intValue] == 2) {
                    //认证通过
                    self.teacherStatus = 2;
                }else if([user.cardstatu intValue] == 1 || [user.educationstatu intValue] == 1){
                    //认证中
                    self.teacherStatus = 3;
                }else if ([user.cardstatu intValue] == 3 || [user.educationstatu intValue] == 3){
                    //认证失败
                    self.teacherStatus = 4;
                }else{
                    self.teacherStatus = 1;
                }
            }
        }
        [self loadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherSearchListApi *api = [[JYXHomeTeacherSearchListApi alloc] initWithUserid:user.userId WithToken:user.token];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        self.dataSourceArray = [array mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (self.dataSourceArray.count >0) {
            //有数据 先显示数据
//            [self.v_back setHidden:YES];
//            [self.tableView setHidden:NO];
//            [self.lb_noData setHidden:YES];
            self.tableView.backgroundView = nil;
        }else{
            //没数据  先判断认证状态 如果认证通过显示接单设置 如果都通过 显示暂无数据
            if (self.teacherStatus != 5) {
                //显示按钮
                if (self.teacherStatus == 0 || self.teacherStatus == 1) {
                    //未认证
//                    [self.v_back setHidden:NO];
//                    [self.tableView setHidden:YES];
//                    [self.lb_noData setHidden:YES];
                    self.tableView.backgroundView = self.v_back;
                    [self.btn_action setTitle:@"去认证" forState:UIControlStateNormal];
                    [self.lb_detail setText:@"您尚未进行认证"];
                    return ;
                }else if (self.teacherStatus == 2){
                    //认证通过
                    JYXUser *user = [JYXUserManager shareInstance].user;
                    if ([user.planhour intValue] == 0 || user.gradesubject.count == 0) {
                        //显示接单设置按钮
//                        [self.v_back setHidden:NO];
//                        [self.tableView setHidden:YES];
//                        [self.lb_noData setHidden:YES];
                        self.tableView.backgroundView = self.v_back;
                        [self.btn_action setTitle:@"接单设置" forState:UIControlStateNormal];
                        [self.lb_detail setText:@"您还未进行接单设置，系统将自动为您安排年级科目进行展示，请尽快完成接单设置。"];
                    }else{
                        //进行了接单设置   显示暂无数据
//                        [self.v_back setHidden:YES];
//                        [self.tableView setHidden:YES];
//                        [self.lb_noData setHidden:NO];
                        self.tableView.backgroundView = self.lb_noData;
                    }
                    return ;
                }else if (self.teacherStatus == 3){
                    //认证中
//                    [self.v_back setHidden:YES];
//                    [self.tableView setHidden:YES];
//                    [self.lb_noData setHidden:NO];
                    self.tableView.backgroundView = self.lb_noData;
                    [self.lb_noData setText:@"认证中请耐心等待"];
                    return ;
                }else if (self.teacherStatus == 4){
                    //认证失败
//                    [self.v_back setHidden:NO];
                    self.tableView.backgroundView = self.v_back;
                    [self.btn_action setHidden:NO];
                    [self.btn_action setTitle:@"重新认证" forState:UIControlStateNormal];
                    [self.lb_detail setText:@"您的认证审核未通过"];
//                    [self.tableView setHidden:YES];
//                    [self.lb_noData setHidden:YES];
                    return ;
                }
            }else{
                //显示暂无数据
                [self.v_back setHidden:YES];
                [self.tableView setHidden:YES];
                [self.lb_noData setHidden:NO];
                self.tableView.backgroundView = self.lb_noData;
            }
        }
        [self.tableView reloadData];
    } failure:^(__kindof RXBaseRequest *request) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -
- (void)btn_actionAction{
    if ([self.btn_action.titleLabel.text isEqualToString:@"去认证"] || [self.btn_action.titleLabel.text isEqualToString:@"重新认证"]) {
        if ([[self.dic_teacherInfo objectForKey:@"cardname"] isEqualToString:@""]) {
            //去基本设置界面
            JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //去身份、学历认证界面
            JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //去接单设置界面
        JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -
- (void)naviRightAction:(UIButton *)btn
{
    //teacherStatus 0：新账户 1：只进行基本资料认证  2：资质认证通过 3.认证中 4.认证失败
    if (self.teacherStatus == 0 || self.teacherStatus == 1 || self.teacherStatus == 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.teacherStatus == 0) {
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
        [again setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
        [cancel setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
        [alert addAction:again];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (self.teacherStatus == 3){
        [MBProgressHUD showInfoMessage:@"认证中请耐心等待"];
    }else{
        JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //teacherStatus 0：新账户 1：只进行基本资料认证  2：资质认证通过 3.认证中 4.认证失败 5.接单设置完成（可操作账户）
    if (self.teacherStatus != 5) {
        //不能接单
        if (self.teacherStatus == 0 || self.teacherStatus == 1) {
            //未认证
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.teacherStatus == 0) {
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
            [again setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [cancel setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:again];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            return ;
        }else if (self.teacherStatus == 2){
            //认证通过
            JYXUser *user = [JYXUserManager shareInstance].user;
            if ([user.planhour intValue] == 0 || user.gradesubject.count == 0) {
                //提示进行接单设置
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行接单设置" message:@"是否立即设置？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                [alert addAction:again];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                //进行了接单设置   跳转
                JYXCourseDetailViewController *vc = [[JYXCourseDetailViewController alloc] init];
                vc.courseType = @2;
                vc.courseId = self.dataSourceArray[indexPath.row][@"id"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            return ;
        }else if (self.teacherStatus == 3){
            //认证中 提示
            [MBProgressHUD showInfoMessage:@"认证中请耐心等待"];
            return ;
        }else if (self.teacherStatus == 4){
            //认证失败 给认证弹窗
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.teacherStatus == 0) {
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
            [again setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
            [cancel setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
            [alert addAction:again];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            return ;
        }
    }else{
        //跳转
        JYXCourseDetailViewController *vc = [[JYXCourseDetailViewController alloc] init];
        vc.courseType = @2;
        vc.courseId = self.dataSourceArray[indexPath.row][@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXTakeOrderTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTakeOrderTableViewCell *mCell = (JYXTakeOrderTableViewCell *)cell;
    [mCell configTakeOrderCellWithData:self.dataSourceArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.picArrs.count > 0) {
        
        _pageViewCode = [ScottPageView pageViewWithImageArr:self.picArrs andImageClickBlock:^(NSInteger index) {
            NSLog(@"点击代码创建的第%ld张图片",index+1);
            JYXShareWebViewViewController *vc = [[JYXShareWebViewViewController alloc]init];
            vc.str_title = [[self.adArrs objectAtIndex:index] objectForKey:@"title"];
            vc.str_url = [[self.adArrs objectAtIndex:index] objectForKey:@"url"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        _pageViewCode.time = 3;
        return _pageViewCode;
        
    }else{
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.picArrs.count > 0) {
        return 95;
    }else{
        return 0.01f;
    }
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
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 159;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableViewDelegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = EdgeInsets(4, 0, 0, 0);
        
        [_tableView registerClass:[JYXTakeOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXTakeOrderTableViewCell class])];
    }
    return _tableView;
}

@end
