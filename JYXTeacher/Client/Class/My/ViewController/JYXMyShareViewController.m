//
//  JYXMyShareViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyShareViewController.h"
#import "JYXShareListViewController.h"
#import <UShareUI/UShareUI.h>
#import "TakeOrderSettingHandler.h"
#import "JYXCertificationBaseInfoViewController.h"
#import "JYXCertificationMaterialsViewController.h"
#import "JYXShareListChildViewController.h"

@interface JYXMyShareViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIImageView  *contentView;
@property (nonatomic, strong) UILabel      *inviteFriendTitleLabel;
@property (nonatomic, strong) UIButton     *inviteFriendBtn;
@property (nonatomic, assign) int          teacherStatus;

@end

@implementation JYXMyShareViewController
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
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#FF4934"] size:CGSizeMake(SCREEN_WIDTH, SafeAreaTopHeight)];
    UIImage *shadowImage = [UIImage imageWithColor:[UIColor clearColor]
                                              size:CGSizeMake(self.navigationController.navigationBar.size.width, 0.5)];
    
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:shadowImage];
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
    UIImage *backgroundImage = [UIImage imageNamed:@"navBarBg"];
    UIImage *shadowImage = [UIImage imageWithColor:[UIColor clearColor]
                                              size:CGSizeMake(self.navigationController.navigationBar.size.width, 0.5)];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"我要共享", nil);
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#ff4934"]];
    [self setRightBarButton];
    [self loadData];
    [self selectTeacherStatus];
}

- (void)setupViews
{
    [self.view addSubview:self.mScrollView];
    [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mScrollView);
        make.width.offset(SCREEN_WIDTH);
        make.height.equalTo(@(SCREEN_WIDTH*(2065.0/750.0)));
    }];
    
    [self.contentView addSubview:self.inviteFriendTitleLabel];
    [self.inviteFriendTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_HEIGHT >= 812) {
           make.top.equalTo(self.contentView).offset(Iphone6ScaleHeight(250));
        }else{
            make.top.equalTo(self.contentView).offset(Iphone6ScaleHeight(300));
        }
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.inviteFriendBtn];
    [self.inviteFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteFriendTitleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
        make.width.offset(Iphone6ScaleWidth(289));
        if (IS_IPHONE_X) {
            make.height.offset(Iphone6ScaleHeight(72));
        }else{
            make.height.offset(Iphone6ScaleHeight(92));
        }
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

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -
- (void)setRightBarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(shareListAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"shareList"] forState:UIControlStateNormal];
    // 设置尺寸
    btn.size = CGSizeMake(80, 15);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)shareListAction:(UIButton *)btn
{
    JYXShareListChildViewController *vc = [[JYXShareListChildViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fenxiangAction{
    
    if (self.teacherStatus == 0 || self.teacherStatus == 1 ) {
        //弹窗提示去认证
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您尚未进行认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *again = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.teacherStatus == 1 || self.teacherStatus == 4) {
                //只进行了基本资料认证  去资料设置界面
                JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //跳到基本认证
                JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
        [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
        [alert addAction:cancel];
        [alert addAction:again];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (self.teacherStatus == 4){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的认真审核未通过" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *again = [UIAlertAction actionWithTitle:@"重新认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [cancel setValue:[UIColor colorWithHexString:@"#bebebe"] forKey:@"titleTextColor"];
        [again setValue:[UIColor colorWithHexString:@"#1caafe"] forKey:@"titleTextColor"];
        [alert addAction:cancel];
        [alert addAction:again];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (self.teacherStatus == 3){
        //弹窗提示认证中
        [MBProgressHUD showInfoMessage:@"认证中请耐心等候"];
    }else{
        //跳转界面
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone), @(UMSocialPlatformType_QQ)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
        }];
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mmbiz.qlogo.cn/mmbiz_png/icb9PjKn9vwiasv57dUhY6ibUhfic0HEJWiaRUqhSnoVN7tgD9aBIB61qDgumCgNgM9l1jt6yhytZmqh8wkU4iarfghg/0?wx_fmt=png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"教予学教师版" descr:@"您的好友邀请您一起使用教予学" thumImage:thumbURL];
    //设置网页地址
    JYXUser *user = [JYXUserManager shareInstance].user;
    NSString * userid = user.userId;
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://www.jiaoyuxuevip.com/home/share/share?id=%@&type=1&from=singlemessage", userid];
    NSLog(@"%@", shareObject.webpageUrl);
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [MBProgressHUD showInfoMessage:@"分享失败"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
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
    }
    return _mScrollView;
}

- (UIImageView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIImageView alloc] init];
        _contentView.image = [UIImage imageNamed:@"myShare_bg"];
        _contentView.userInteractionEnabled = YES;
        [_contentView sizeToFit];
    }
    return _contentView;
}

- (UILabel *)inviteFriendTitleLabel
{
    if (!_inviteFriendTitleLabel) {
        _inviteFriendTitleLabel = [[UILabel alloc] init];
        _inviteFriendTitleLabel.text = NSLocalizedString(@"邀请一名好友成为教予学用户", nil);
        _inviteFriendTitleLabel.font = FONT_SIZE(15);
        _inviteFriendTitleLabel.textColor = [UIColor whiteColor];
        [_inviteFriendTitleLabel sizeToFit];
    }
    return _inviteFriendTitleLabel;
}

- (UIButton *)inviteFriendBtn
{
    if (!_inviteFriendBtn) {
        _inviteFriendBtn = [[UIButton alloc] init];
        [_inviteFriendBtn setBackgroundImage:[UIImage imageNamed:@"inviteFriend"] forState:UIControlStateNormal];
        _inviteFriendBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_inviteFriendBtn addTarget:self action:@selector(fenxiangAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inviteFriendBtn;
}

@end
