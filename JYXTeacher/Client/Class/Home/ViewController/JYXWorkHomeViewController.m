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
#import "JYXCertificationMaterialsViewController.h"
#import "AGBaseTabBarController.h"
#import "UITabBar+littleRedDotBadge.h"

@interface JYXWorkHomeViewController ()<WLPageViewDataSource, WLPageViewDelegate,RCIMReceiveMessageDelegate>
@property (nonatomic, strong) WLPageView *pageView;
@property (nonatomic, strong) NSMutableArray *vcArrM;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, assign) int            teacherStatus;
//teacherStatus 0：新账户 1：只进行基本资料认证  2：资质认证通过 3.认证中 4.认证失败 5.接单设置完成（可操作账户）

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //上传版本号
        [TeacherWorkHandler postVersionSystemWithNum:nil type:nil prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            if ([[dic objectForKey:@"code"] intValue] == 1000) {
                if ([[[dic objectForKey:@"result"] objectForKey:@"update"] isEqualToString:@"Yes"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"有新的版本" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *again = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E6%95%99%E4%BA%88%E5%AD%A6-%E6%95%99%E5%B8%88%E7%89%88/id1436676442?mt=8"]];
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
                    [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
                    [alert addAction:cancel];
                    [alert addAction:again];
                    [[JYXBaseViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
                }
            }else if ([[dic objectForKey:@"code"] intValue] == 1001){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E6%95%99%E4%BA%88%E5%AD%A6-%E6%95%99%E5%B8%88%E7%89%88/id1436676442?mt=8"]];
                }];
                [alert addAction:again];
                [[JYXBaseViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
            }
            
        } failed:^(NSInteger statusCode, id json) {
            
        }];
        
    });
    
    //连接融云服务器
    [self connectRCIM];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(renzhengshibaiAction) name:@"renzhengshibai" object:nil];
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
        //先判断是否进行资质认证  认证通过后才可以进行接单设置
        JYXUser *user = [JYXUserManager shareInstance].user;
        if ([user.cardname isEqualToString:@""]) {
            self.teacherStatus = 0;
        }else{
            if ([user.teachertype isEqualToString:@"全职教师"] || [user.teachertype isEqualToString:@"大学生"]|| [user.teachertype isEqualToString:@"自由教师"]) {
                if ([user.cardstatu intValue] == 2 && [user.educationstatu intValue] == 2) {
                    //认证通过
                    self.teacherStatus = 2;
                }else if([user.cardstatu intValue] == 1 && [user.educationstatu intValue] == 1){
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
            JYXUser *user = [JYXUserManager shareInstance].user;
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:user.cardname portrait:user.avatar];
            [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
        [self setBadageNum];
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
    //teacherStatus 0：新账户 1：只进行基本资料认证  2：资质认证通过 3.认证中 4.认证失败 5.接单设置完成（可操作账户）
    if (self.teacherStatus == 0 || self.teacherStatus == 1 || self.teacherStatus == 4) {
        if (self.teacherStatus == 0 || self.teacherStatus == 1) {
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
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的认真审核未通过" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"重新认证 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
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
        }
        
    }else if (self.teacherStatus == 3){
        [MBProgressHUD showInfoMessage:@"认证中请耐心等待"];
    }else{
        JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.takeOrderSettingComplete = ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"takeOrderSettingComplete" object:nil];
        };
    }
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

- (void)renzhengshibaiAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的认证审核未通过" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"稍后认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"立即认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳到资质认证
        JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [again setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
    [alert addAction:again];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

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

#pragma mark - RongColude-cDelegate          - Method -
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setBadageNum];
    });
}

-(void)setBadageNum{
    
    NSInteger unreadMessageCount = [self getUnreadCount];
    
    // 设置tabbar 的icon
    AGBaseTabBarController *tabbar = (AGBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController ;
    if ([tabbar isKindOfClass:[AGBaseTabBarController class]]) {
        
        // 如果没有未读消息返回值为nil
        if (unreadMessageCount == 0 || unreadMessageCount == (long)nil) {
            [tabbar.tabBar hideNumBadgeOnItemIndex:1];
        }else{
            [tabbar.tabBar showNumBadgeOnItemIndex:1 Count:(int)unreadMessageCount];
        }
    }
    
}

-(NSInteger)getUnreadCount{
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    return unreadMsgCount ;
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
        
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x000000], NSFontAttributeName:FONT_SIZE(15)};
        
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
