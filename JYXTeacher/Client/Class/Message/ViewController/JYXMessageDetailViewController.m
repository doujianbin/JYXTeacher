//
//  JYXMessageDetailViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/10/11.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMessageDetailViewController.h"
#import "MyHandler.h"

@interface JYXMessageDetailViewController ()

@end

@implementation JYXMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftBarButton:@"navi_Return"];
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
