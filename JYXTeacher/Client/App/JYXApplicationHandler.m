//
//  JYXApplicationHandler.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXApplicationHandler.h"
#import "JYXInitializeApplication.h"
#import "JYXApplicationConfig.h"
#import "JYXLoginViewController.h"
#import "ShowBigPhotoView.h"
#import "TeacherWorkHandler.h"
#import "JYXPayPenaltyViewController.h"
#import "MyHandler.h"

@interface JYXApplicationHandler ()

/** 应用的缺省窗口 */
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIImageView *splashView;
@property (nonatomic,strong)ShowBigPhotoView   *v_launch;

@end

@implementation JYXApplicationHandler

+ (JYXApplicationHandler *)shareInstance
{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initApplicationHandler];
    }
    return self;
}

- (void)initApplicationHandler
{
    [self.window makeKeyAndVisible];
}

/**
 *  初始化应用
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /// 要先设置根视图然后再显示 splash 屏幕，否则 splash 屏幕会显示在下面。
    UIViewController *navi = [[UIViewController alloc] init];
    self.window.rootViewController = navi;
    
    //    [[JYXApplicationHandler shareInstance] showSplashView];
    
    /// 初始化App配置
    [JYXApplicationConfig getServerAddressList];
    /// 初始化用户数据
    [[JYXUserManager shareInstance] load];
    //初始化融云
    [[RCIM sharedRCIM] initWithAppKey:RCIMAppKey];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIViewController *vc = [JYXInitializeApplication initialize:application options:launchOptions];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initializeFinished:vc];
        });
    });
    
    //上传推送注册id
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:Registionid] length] > 0) {
        
        [MyHandler pushJpushRegistionidWithRegistionid:[[NSUserDefaults standardUserDefaults] valueForKey:Registionid] prepare:^{
            
        } success:^(id obj) {
            
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
    
    return YES;
}

- (void)initializeFinished:(UIViewController *)firstVC
{
    AppDelegate *appdelegate = (AppDelegate *)kAppDelegate;
    appdelegate.firstVC = firstVC;
    //判断是否已登录
    BOOL isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:IsLogin];
    if (isLogin == NO) {
        JYXLoginViewController *vc = [[JYXLoginViewController alloc] init];
        self.window.rootViewController = vc;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLookDaoHang] == NO)
        {
            [self setLaunchView];
        }
    } else {
        self.window.rootViewController = firstVC;
    }
    //    [[JYXApplicationHandler shareInstance] hideSplashView];
}

- (void)setLaunchView{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLookDaoHang];
    if (SCREEN_HEIGHT >= 812) {
        self.v_launch = [[ShowBigPhotoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withImagesArray:@[@"lunchIphonex1",@"lunchIphonex2",@"lunchIphonex3",@"lunchIphonex4"] index:0];
    }else{
        self.v_launch = [[ShowBigPhotoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withImagesArray:@[@"launch1",@"launch2",@"launch3",@"launch4"] index:0];
    }
    [self.v_launch.btn_next addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.v_launch];
    [self.window bringSubviewToFront:self.v_launch];
}

- (void)nextAction{
    if (self.v_launch) {
        [UIView animateWithDuration:0.3 animations:^{
            self.v_launch.alpha = 0;
        } completion:^(BOOL finished) {
            [self.v_launch removeFromSuperview];
            self.v_launch = nil;
        }];
    }
}

/**
 *  显示 Splash 界面，Splash 是一个 View 直接放到当前的 window 上。
 */
- (void)showSplashView
{
    NSString *imagedir = @"Assets/Splash";
    
    NSString * imageFile;
    int sh = [UIScreen mainScreen].bounds.size.height;
    
    if (IS_IPHONE_4_OR_LESS) {
        imageFile = [NSString stringWithFormat:@"%@/splash.png", imagedir];
    } else if(IS_IPHONE_6P){
        imageFile = [NSString stringWithFormat:@"%@/splash_%dh.png", imagedir,sh];
    } else if(IS_IPHONE_X){
        imageFile = [NSString stringWithFormat:@"%@/splash_%dh.png", imagedir,sh];
    } else if (IS_IPAD) {
        imageFile = [NSString stringWithFormat:@"%@/splash_%dh.png", imagedir,sh];
    } else {
        imageFile = [NSString stringWithFormat:@"%@/splash_736h.png", imagedir];
    }
    self.splashView.image = [UIImage imageNamed:imageFile];
    [self.window addSubview:self.splashView];
}

/**
 *  隐藏 splash 窗口
 */
- (void)hideSplashView
{
    if (!self.splashView) return;
    
    [UIView animateWithDuration:.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.splashView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.splashView removeFromSuperview];
                         self.splashView = nil;
                     }];
}

- (UIImageView *)splashView
{
    if (!_splashView) {
        _splashView = [[UIImageView alloc] init];
        _splashView.backgroundColor = [UIColor whiteColor];
        _splashView.frame = _window.bounds;
    }
    return _splashView;
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

@end

