//
//  JYXShareWebViewViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/11/2.
//  Copyright © 2018 JYX. All rights reserved.
//

#import "JYXShareWebViewViewController.h"
#import "WebViewJavascriptBridge.h"
#import <UShareUI/UShareUI.h>
#import "TableBackgroudView.h"

@interface JYXShareWebViewViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@property (nonatomic,strong) NSDictionary *dic_data;
//@property (nonatomic,strong) NormalShareUtils        *shareUtils;
//@property (nonatomic,strong) TableBackgroudView      *networkErrorView;

@end

@implementation JYXShareWebViewViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    
    if (_bridge) {
        return;
    }
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.webView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.str_url]];
    JYXUser *user =  [[JYXUserManager shareInstance]user];
    
    if (user.userId.length > 0) {
        [request setValue:user.userId forHTTPHeaderField:@"JYXUserId"];
    }
    if (user.token.length > 0) {
        [request setValue:user.token forHTTPHeaderField:@"JYXToken"];
    }
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [request setValue:version forHTTPHeaderField:@"JYXVersion"];
    [_webView loadRequest:request];
    
    //设置能够进行桥接
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [_bridge setWebViewDelegate:self];
    
//    WS(weakSelf);
    
    [_bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.dic_data = (NSDictionary *)data;

        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone), @(UMSocialPlatformType_QQ)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
        }];
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [_bridge registerHandler:@"cancel" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [self.navigationController popViewControllerAnimated:YES];
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mmbiz.qlogo.cn/mmbiz_png/icb9PjKn9vwiasv57dUhY6ibUhfic0HEJWiaRUqhSnoVN7tgD9aBIB61qDgumCgNgM9l1jt6yhytZmqh8wkU4iarfghg/0?wx_fmt=png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[self.dic_data objectForKey:@"title"] descr:[self.dic_data objectForKey:@"desc"] thumImage:thumbURL];
    //设置网页地址

    shareObject.webpageUrl = [self.dic_data objectForKey:@"blogURL"];
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
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = self.str_title;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [_progressLayer finishedLoad];
    
}

- (void)dealloc
{
    [_webView stopLoading];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [_progressLayer startLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // finished loading,hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    [_progressLayer finishedLoad];
//    [self.networkErrorView removeFromSuperview];
//    self.networkErrorView = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@ 错误",error);
//    [_progressLayer finishedLoad];
//    if (error.code == -1009) {
//        if (self.networkErrorView == nil) {
//            UIButton *btn_loadData = [[UIButton alloc] init];
//            [btn_loadData addTarget:self action:@selector(reloadWebViewInvoked:) forControlEvents:UIControlEventTouchUpInside];
//            self.networkErrorView = [[TableBackgroudView alloc]initWithFrame:self.view.frame withDefaultImage:[UIImage imageNamed:@"default_error"] withNoteTitle:ERROR_NETWORK_TEXT withNoteDetail:nil withButtonAction:btn_loadData];
//            [self.view addSubview:self.networkErrorView];
//        }
//    }
}

- (void)reloadWebViewInvoked:(id)sender{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.str_url]];
//    if ([UserStorage uuid]) {
//        [request setValue:[UserStorage uuid] forHTTPHeaderField:@"x-docchat-user-id"];
//    }
//    if ([UserStorage sessionToken]) {
//        [request setValue:[UserStorage sessionToken] forHTTPHeaderField:@"x-docchat-session-token"];
//    }
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    [request setValue:version forHTTPHeaderField:@"x-docchat-app-version"];
//    [_webView loadRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
