//
//  AGTabBarController.m
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import "AGTabBarController.h"
#import "JYXWorkHomeViewController.h"
#import "JYXMessageViewController.h"
#import "JYXMyHomeViewController.h"

@interface AGTabBarController ()

@end

@implementation AGTabBarController

#pragma mark - lifeCycle                    - Method -

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupAllChildViewControllers
{
    JYXWorkHomeViewController *workHomeVC = [[JYXWorkHomeViewController alloc] init];
    [self setupChildViewController:workHomeVC
                             title:@"工作"
                         imageName:@"TabBar_home"
                 selectedImageName:@"TabBar_home_Sel"
                     hasNavigation:YES];
    
    JYXMessageViewController *messageHomeVC = [[JYXMessageViewController alloc] init];
    [self setupChildViewController:messageHomeVC
                             title:@"消息"
                         imageName:@"TabBar_message"
                 selectedImageName:@"TabBar_message_Sel"
                     hasNavigation:YES];
    
    JYXMyHomeViewController *myHomeVC = [[JYXMyHomeViewController alloc] init];
    [self setupChildViewController:myHomeVC
                             title:@"我的"
                         imageName:@"TabBar_my"
                 selectedImageName:@"TabBar_my_Sel"
                     hasNavigation:YES];
}

/** 拦截TabBar的点击事件 */
- (BOOL)shouldSelectViewControllerFromIndex:(NSInteger)index
{
    return YES;
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

- (void)didSelectedButtonFrom:(NSInteger)from toIndex:(NSInteger)index
{
    //双击刷新制定页面的列表
    if (self.selectedIndex == index && index == 0 ) {

    }
}

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -

@end
