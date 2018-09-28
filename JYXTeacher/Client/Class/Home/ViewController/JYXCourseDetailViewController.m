//
//  JYXCourseDetailViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXCourseDetailViewController.h"
#import "JYXCourseDetailTopBarView.h"
#import "JYXCourseInfoView.h"//授课方式等基本信息
#import "JYXCourseDemandView.h"//需求描述
#import "JYXCoursePersonNumberView.h"//上课人数
#import "JYXCourseCostView.h"//课程费用明细
#import "JYXCourseDetailBottomBarView.h"
#import "JYXHomeTeacherSearchInfoApi.h"
#import "JYXCourseHomeworkViewController.h"
#import "JYXHomeTeacherCourseStatuApi.h"
#import "JYXAppraiseViewController.h"
#import "JYXReportViewController.h"
#import "JYXHomeTeacherSearchteacherGrabApi.h"
#import "JYXHomeTeacherSearchRemoveApi.h"
#import "TeacherWorkHandler.h"

@interface JYXCourseDetailViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIView *contentView;
/** 课程明细顶部个人信息 */
@property (nonatomic, strong) JYXCourseDetailTopBarView *topBarBgView;
//课程基本信息
@property (nonatomic, strong) JYXCourseInfoView *courseInfoView;
//课程需求描述
@property (nonatomic, strong) JYXCourseDemandView *courseDemandView;
//上课人数
@property (nonatomic, strong) JYXCoursePersonNumberView *coursePersonNumberView;
//课程费用明细
@property (nonatomic, strong) JYXCourseCostView *courseCostView;

@property (nonatomic, strong) UIView *totalIncomeBgView;//收入合计
@property (nonatomic, strong) UILabel *totalIncomeTitleLabel;
@property (nonatomic, strong) UILabel *totalIncomeLabel;

//底部bar
@property (nonatomic, strong) JYXCourseDetailBottomBarView *bottomBarView;

@property (nonatomic, assign)int bottomType;    //底部类型 0.待上课 1.已上课（未评价） 2.抢单 3.已上课（已评价）
@property (nonatomic ,strong) NSDictionary *dict;  //保存当前订单数据的字典

@end

@implementation JYXCourseDetailViewController
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
    self.navigationItem.title = NSLocalizedString(@"课程明细", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.topBarBgView];
    [self.topBarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.offset(77);
    }];
    
    [self.view addSubview:self.mScrollView];
    [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topBarBgView.mas_bottom);
    }];
    
    [self.mScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mScrollView);
        make.width.equalTo(self.mScrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    [self.view addSubview:self.bottomBarView];
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.mScrollView.mas_bottom);
        make.height.offset(73);
    }];
    
    [self.bottomBarView.previewHomeworkBtn addTarget:self action:@selector(previewHomeworkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.courseFinishBtn addTarget:self action:@selector(courseFinishBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.communicateBtn addTarget:self action:@selector(communicateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.afterHomeworkBtn addTarget:self action:@selector(afterHomeworkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.appraiseBtn addTarget:self action:@selector(appraiseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.communicateBtn1 addTarget:self action:@selector(communicateBtn1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.reportBtn addTarget:self action:@selector(reportBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBarView.takeOrderBtn addTarget:self action:@selector(takeOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.courseCostView.helpImg addTarget:self action:@selector(helpImgAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.courseCostView.fundImg addTarget:self action:@selector(fundImgAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.courseInfoView];
    [self.courseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.courseDemandView];
    [self.courseDemandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.courseInfoView.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.coursePersonNumberView];
    [self.coursePersonNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.courseDemandView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.courseCostView];
    [self.courseCostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.right.equalTo(self.contentView).offset(-7);
        make.top.equalTo(self.coursePersonNumberView.mas_bottom).offset(40);
    }];
    
    [self.contentView addSubview:self.totalIncomeBgView];
    [self.totalIncomeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.offset(43);
        make.top.equalTo(self.courseCostView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.totalIncomeBgView addSubview:self.totalIncomeTitleLabel];
    [self.totalIncomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalIncomeBgView);
        make.left.equalTo(self.totalIncomeBgView).offset(7);
    }];
    
    [self.totalIncomeBgView addSubview:self.totalIncomeLabel];
    [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.totalIncomeBgView);
        make.right.equalTo(self.totalIncomeBgView).offset(-7);
    }];
    
}

- (void)loadData
{
    
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherSearchInfoApi *api = [[JYXHomeTeacherSearchInfoApi alloc] initWithUserid:user.userId WithToken:user.token courseId:self.courseId type:self.courseType];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.dict = [api fetchDataWithReformer:request];
        NSLog(@"需求明细%@",self.dict);
        [self.topBarBgView configCourseDetailTopBarViewWithData:self.dict];
        [self.courseInfoView configCourseInfoViewWithData:self.dict];
        [self.courseDemandView configCourseDemandViewWithData:self.dict];
        [self.coursePersonNumberView configCoursePersonNumberViewWithData:self.dict];
        [self.courseCostView configCourseCostViewWithData:self.dict];
        self.totalIncomeLabel.text = [NSString stringWithFormat:@"%@",self.dict[@"teacherPrice"]];
        if ([self.courseType intValue] == 0) {
            self.bottomType = [self.courseType intValue] + 1;
        }
        else if ([self.courseType intValue] == 1) {
            if ([self.dict[@"teachercontent"] isEqualToString:@""]) {
                self.bottomType = [self.courseType intValue]+ 1;
            }else{
                self.bottomType = 3+ 1;
            }
        }else{
            self.bottomType = [self.courseType intValue]+ 1;
        }
        
        [self.bottomBarView configCourseDetailBottomBarViewWithData:self.bottomType];
        
        if ([self.dict[@"status"] isEqualToString:@"待抢单"]) {
            [self.bottomBarView.takeOrderBtn setTitle:NSLocalizedString(@"抢单", nil) forState:UIControlStateNormal];
        }else{
            [self.bottomBarView.takeOrderBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        }
        
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -

- (void)helpImgAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保险费用" message:@"外出上课时，平台强制购买保险每次由系统自动从账户扣费" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fundImgAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"公益基金" message:@"成交后老师每课时收入都将捐赠0.05元作为公益基金" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)previewHomeworkBtnAction{
    JYXCourseHomeworkViewController *vc = [[JYXCourseHomeworkViewController alloc] init];
    vc.courseId = self.dict[@"id"];
    vc.type = @1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)courseFinishBtnAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"是否完成？", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    WeakSelf(weakSelf);
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf(strongSelf);
        JYXUser *user = [JYXUserManager shareInstance].user;
        JYXHomeTeacherCourseStatuApi *api = [[JYXHomeTeacherCourseStatuApi alloc] initWithUserid:user.userId WithToken:user.token courseId:strongSelf.dict[@"id"] type:@"1"];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            //            if (self.deleteCellBlock) {
            //                self.deleteCellBlock(strongSelf.dictCellData);
            //            }
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)communicateBtnAction{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"电话沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TeacherWorkHandler selectXuNiPhoneNumWithPhone:[[NSUserDefaults standardUserDefaults] valueForKey:TeacherPhone] otherphone:[[[self.dict objectForKey:@"studentData"] objectAtIndex:0] objectForKey:@"phone"] prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str_phone = [[dic objectForKey:@"binding_Relation_response"] objectForKey:@"smbms"];
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",str_phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"在线沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RCConversationViewController *vc = [[RCConversationViewController alloc] init];
        vc.conversationType = ConversationType_PRIVATE;
        vc.targetId = self.dict[@"longid"];
        vc.title = self.dict[@"studentname"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [[JYXBaseViewController getCurrentVC] presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)afterHomeworkBtnAction{
    JYXCourseHomeworkViewController *vc = [[JYXCourseHomeworkViewController alloc] init];
    vc.courseId = self.dict[@"id"];
    vc.type = @2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)appraiseBtnAction{
    JYXAppraiseViewController *vc = [[JYXAppraiseViewController alloc] init];
    [vc setResult:self.dict];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)communicateBtn1Action{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"电话沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TeacherWorkHandler selectXuNiPhoneNumWithPhone:[[NSUserDefaults standardUserDefaults] valueForKey:TeacherPhone] otherphone:[[[self.dict objectForKey:@"studentData"] objectAtIndex:0] objectForKey:@"phone"] prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str_phone = [[dic objectForKey:@"binding_Relation_response"] objectForKey:@"smbms"];
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",str_phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"在线沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RCConversationViewController *vc = [[RCConversationViewController alloc] init];
        vc.conversationType = ConversationType_PRIVATE;
        vc.targetId = self.dict[@"longid"];
        vc.title = self.dict[@"studentname"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [[JYXBaseViewController getCurrentVC] presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)reportBtnAction{
    JYXReportViewController *vc = [[JYXReportViewController alloc]init];
    vc.dic_data = self.dict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)takeOrderBtnAction{
    JYXUser *user = [JYXUserManager shareInstance].user;
    if ([self.dict[@"status"] isEqualToString:@"待抢单"]) {//抢单
        JYXHomeTeacherSearchteacherGrabApi *api = [[JYXHomeTeacherSearchteacherGrabApi alloc] initWithUserid:user.userId WithToken:user.token courseId:self.dict[@"id"]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [self.bottomBarView.takeOrderBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
            [self loadData];
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    } else if ([self.dict[@"status"] isEqualToString:@"抢单中"]) {//取消抢单
        JYXHomeTeacherSearchRemoveApi *api = [[JYXHomeTeacherSearchRemoveApi alloc] initWithUserid:user.userId WithToken:user.token courseId:self.dict[@"id"]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [self.bottomBarView.takeOrderBtn setTitle:NSLocalizedString(@"抢单", nil) forState:UIControlStateNormal];
            [self loadData];
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] init];
        _mScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mScrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (JYXCourseDetailTopBarView *)topBarBgView
{
    if (!_topBarBgView) {
        _topBarBgView = [[JYXCourseDetailTopBarView alloc] init];
    }
    return _topBarBgView;
}

- (JYXCourseInfoView *)courseInfoView
{
    if (!_courseInfoView) {
        _courseInfoView = [[JYXCourseInfoView alloc] init];
        _courseInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _courseInfoView;
}

- (JYXCourseDemandView *)courseDemandView
{
    if (!_courseDemandView) {
        _courseDemandView = [[JYXCourseDemandView alloc] init];
        _courseDemandView.backgroundColor = [UIColor whiteColor];
    }
    return _courseDemandView;
}

- (JYXCoursePersonNumberView *)coursePersonNumberView
{
    if (!_coursePersonNumberView) {
        _coursePersonNumberView = [[JYXCoursePersonNumberView alloc] init];
        _coursePersonNumberView.backgroundColor = [UIColor whiteColor];
    }
    return _coursePersonNumberView;
}

- (JYXCourseCostView *)courseCostView
{
    if (!_courseCostView) {
        _courseCostView = [[JYXCourseCostView alloc] init];
        JYXViewBorderRadius(_courseCostView, 5, 1, [UIColor colorWithHex:0xc1c1c1]);
        _courseCostView.backgroundColor = [UIColor whiteColor];
    }
    return _courseCostView;
}

- (UIView *)totalIncomeBgView
{
    if (!_totalIncomeBgView) {
        _totalIncomeBgView = [[UIView alloc] init];
        _totalIncomeBgView.backgroundColor = [UIColor whiteColor];
    }
    return _totalIncomeBgView;
}

- (UILabel *)totalIncomeTitleLabel
{
    if (!_totalIncomeTitleLabel) {
        _totalIncomeTitleLabel = [[UILabel alloc] init];
        _totalIncomeTitleLabel.text = NSLocalizedString(@"收入合计", nil);
        _totalIncomeTitleLabel.font = FONT_SIZE(20);
        _totalIncomeTitleLabel.textColor = [UIColor colorWithHex:0x656565];
        [_totalIncomeTitleLabel sizeToFit];
    }
    return _totalIncomeTitleLabel;
}

- (UILabel *)totalIncomeLabel
{
    if (!_totalIncomeLabel) {
        _totalIncomeLabel = [[UILabel alloc] init];
        _totalIncomeLabel.textColor = [UIColor colorWithHex:0xff6937];
        _totalIncomeLabel.font = FONT_SIZE(20);
        [_totalIncomeLabel sizeToFit];
    }
    return _totalIncomeLabel;
}

- (JYXCourseDetailBottomBarView *)bottomBarView
{
    if (!_bottomBarView) {
        _bottomBarView = [[JYXCourseDetailBottomBarView alloc] init];
        _bottomBarView.backgroundColor = [UIColor clearColor];
    }
    return _bottomBarView;
}

@end

