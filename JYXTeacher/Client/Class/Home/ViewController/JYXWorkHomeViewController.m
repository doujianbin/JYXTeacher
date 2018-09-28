//
//  JYXWorkHomeViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWorkHomeViewController.h"
#import "HMSegmentedControl.h"
#import "WLPageView.h"
#import "JYXWaitLessonViewController.h"
#import "JYXAlreadyLessonViewController.h"
#import "JYXTakeOrderViewController.h"
#import "JYXTakeOrdersSetViewController.h"// 接单设置
#import "JYXScheduleViewController.h"// 总课表
#import "JYXHomeMesRongcloudApi.h"
#import "JYXPayPenaltyViewController.h"
#import "TeacherWorkHandler.h"
#import "JYXPayPenaltyViewController.h"
#import "TakeOrderSettingHandler.h"
#import "JYXCertificationBaseInfoViewController.h"


@interface JYXWorkHomeViewController ()<WLPageViewDataSource, WLPageViewDelegate>
@property (nonatomic, strong) WLPageView *pageView;
@property (nonatomic, strong) NSMutableArray *vcArrM;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@end

@implementation JYXWorkHomeViewController
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
    //连接融云服务器
    [self connectRCIM];
    
    [self setLeftBarButton];
    [self setRightBarButton];
    NSArray *titleArray = @[@"待上课",@"已上课",@"抢单"];
    self.segmentedControl.sectionTitles = titleArray;
    //待上课
    JYXWaitLessonViewController *waitLessonVC = [[JYXWaitLessonViewController alloc] init];
    waitLessonVC.detailVC = self;
    [self.vcArrM addObject:waitLessonVC];
    //已上课
    JYXAlreadyLessonViewController *alreadyLessonVC = [[JYXAlreadyLessonViewController alloc] init];
    alreadyLessonVC.detailVC = self;
    [self.vcArrM addObject:alreadyLessonVC];
    //抢单
    JYXTakeOrderViewController *takeOrderVC = [[JYXTakeOrderViewController alloc] init];
    takeOrderVC.detailVC = self;
    [self.vcArrM addObject:takeOrderVC];
    
    [self.pageView reloadData];
    [self.pageView setSelectedIndex:0];
    
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(45);
    }];
    
    [self.view addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //判断是否需要交纳罚金  如果需要，调到交纳罚金界面
    [TeacherWorkHandler teacherSelectWalletMoneyWithPrepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        if ([dic[@"money"] doubleValue] < 0) {
            //需要交纳罚金
            JYXPayPenaltyViewController *vc = [[JYXPayPenaltyViewController alloc]init];
            vc.str_penalty = dic[@"money"];
//            vc.str_penalty = @"-0.01";
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)loadData
{
    //查询认证状态  如果没认证  给去认证的提示
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherInfoWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSMutableDictionary *)obj;
        NSLog(@"dic = %@",dic);
        if ([dic[@"cardstatu"] intValue] == 0 || [dic[@"educationstatu"] intValue] == 0 || [dic[@"senioritystatu"] intValue] == 0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您还没有进行认证\n请您到设置中进行认证" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [again setValue:[UIColor colorWithHexString:@"#1AABFD"] forKey:@"titleTextColor"];
                JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            [alert addAction:forgetPassword];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - eventResponse                - Method -
- (void)connectRCIM
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeMesRongcloudApi *api = [[JYXHomeMesRongcloudApi alloc] initWithUserId:@(user.teacherId.integerValue) username:user.nickname type:@1];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [[RCIM sharedRCIM] connectWithToken:dict[@"token"]  success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

- (void)naviLeftAction:(UIButton *)btn
{
    JYXScheduleViewController *vc = [[JYXScheduleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)naviRightAction:(UIButton *)btn
{
    JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    JYXPayPenaltyViewController *vc = [[JYXPayPenaltyViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - customDelegate               - Method -
#pragma mark WLPageVeiwDataSource
- (NSInteger)numberOfControllersInWLPageView:(WLPageView *)pageView
{
    return self.vcArrM.count;
}

- (UIViewController *)baseViewControllerInWLPageView:(WLPageView *)pageView
{
    return self;
}

- (UIViewController *)WLPageView:(WLPageView *)pageView controllerAt:(NSInteger)index
{
    return self.vcArrM[index];
}

#pragma mark WLPageVeiwDelegate
- (void)WLPageView:(WLPageView *)slide didSwitchTo:(NSInteger)index
{
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -
- (void)setLeftBarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(naviLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navi_home_left"] forState:UIControlStateNormal];
    [btn setTitle:NSLocalizedString(@"总课表", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(11);
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
}

- (void)setRightBarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(naviRightAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navi_home_right"] forState:UIControlStateNormal];
    [btn setTitle:NSLocalizedString(@"接单设置", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(11);
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
}

#pragma mark HMSegmentedControlAction
- (void)segmentedControlChangedValue:(HMSegmentedControl *)sender
{
    [self.pageView setSelectedIndex:sender.selectedSegmentIndex];
}

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nil];
        [_segmentedControl addTarget:self
                              action:@selector(segmentedControlChangedValue:)
                    forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x1aabfd], NSFontAttributeName:FONT_SIZE(15)};
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x6d6d6d], NSFontAttributeName:FONT_SIZE(15)};
        
        //        _segmentedControl.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        //        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4167b2"]} forState:UIControlStateSelected];
        
        _segmentedControl.selectionIndicatorColor = [UIColor colorWithHex:0x1aabfd];
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.shouldAnimateUserSelection = YES;
    }
    return _segmentedControl;
}

- (WLPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[WLPageView alloc] init];
        _pageView.dataSource = self;
        _pageView.delegae = self;
        _pageView.switchSlide = YES;
    }
    return _pageView;
}

- (NSMutableArray *)vcArrM
{
    if (!_vcArrM) {
        _vcArrM = [NSMutableArray array];
    }
    return _vcArrM;
}

@end
