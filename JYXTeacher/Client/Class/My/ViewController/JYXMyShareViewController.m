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

@interface JYXMyShareViewController ()
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, strong) UILabel *inviteFriendTitleLabel;
@property (nonatomic, strong) UIButton *inviteFriendBtn;
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
//    [self setRightBarButton];
    [self loadData];
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
        make.top.equalTo(self.contentView).offset(Iphone6ScaleHeight(250));
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.inviteFriendBtn];
    [self.inviteFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inviteFriendTitleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
        make.width.offset(Iphone6ScaleWidth(289));
        make.height.offset(Iphone6ScaleHeight(92));
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
    JYXShareListViewController *vc = [[JYXShareListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fenxiangAction{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone), @(UMSocialPlatformType_QQ)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mmbiz.qlogo.cn/mmbiz_png/icb9PjKn9vwiasv57dUhY6ibUhfic0HEJWiaRUqhSnoVN7tgD9aBIB61qDgumCgNgM9l1jt6yhytZmqh8wkU4iarfghg/0?wx_fmt=png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"教予学" descr:@"您的好友邀请您一起使用教予学" thumImage:thumbURL];
    //设置网页地址
    NSString * userid = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
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
            [MBProgressHUD showErrorMessage:@"分享失败"];
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
