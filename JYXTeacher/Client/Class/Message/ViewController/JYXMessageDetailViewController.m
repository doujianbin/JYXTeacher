//
//  JYXMessageDetailViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/10/11.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMessageDetailViewController.h"
#import "MyHandler.h"
#import "AGBaseTabBarController.h"
#import "UITabBar+littleRedDotBadge.h"

@interface JYXMessageDetailViewController ()

@end

@implementation JYXMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftBarButton:@"navi_Return"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setBadageNum];
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


- (void)setLeftBarButton:(NSString *)image
{
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTarget:self
                                                         action:@selector(naviBack)
                                                          image:image
                                                      highImage:image];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)naviBack{
    [self.navigationController popViewControllerAnimated:YES];
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
