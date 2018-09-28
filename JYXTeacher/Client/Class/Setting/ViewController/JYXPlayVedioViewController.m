//
//  JYXPlayVedioViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXPlayVedioViewController.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "AppDelegate.h"


@interface JYXPlayVedioViewController ()

@property (nonatomic, strong) SelVideoPlayer *player;


@end

@implementation JYXPlayVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用视频";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = YES;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:@"http://www.jiaoyuxuevip.com/public/teacher.mp4"];
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, width, 300) configuration:configuration];
    [self.view addSubview:_player];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_player _deallocPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
