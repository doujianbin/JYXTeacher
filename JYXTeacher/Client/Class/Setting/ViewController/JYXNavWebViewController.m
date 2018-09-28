//
//  JYXNavWebViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXNavWebViewController.h"

@interface JYXNavWebViewController ()

@property (nonatomic ,strong)UIWebView      *myWebview;

@end

@implementation JYXNavWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.str_title;
    [self oncreate];
}

- (void)oncreate{
    self.myWebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.myWebview];
    NSURL *requestUrl = [NSURL URLWithString:self.str_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [self.myWebview loadRequest:request];
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
