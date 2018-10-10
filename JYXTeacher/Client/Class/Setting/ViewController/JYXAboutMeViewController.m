//
//  JYXAboutMeViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAboutMeViewController.h"

@interface JYXAboutMeViewController ()
@property (nonatomic ,strong)UILabel *addressExplainLabel;

@end

@implementation JYXAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self oncreate];
}

- (void)oncreate{
    UIImageView *img_icon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 95) / 2, 60, 95, 95)];
    [self.view addSubview:img_icon];
    [img_icon setImage:[UIImage imageNamed:@"150-150"]];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, img_icon.bottom + 15, SCREEN_WIDTH, 22)];
    [self.view addSubview:lb_title];
    [lb_title setText:@"教予学"];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#3892c9"]];
    [lb_title setFont:[UIFont systemFontOfSize:21]];
    [lb_title setTextAlignment:NSTextAlignmentCenter];
    
    _addressExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, lb_title.bottom + 30, SCREEN_WIDTH - 60, 150)];
    [self.view addSubview:_addressExplainLabel];
    _addressExplainLabel.text = NSLocalizedString(@"教予学是一个基于移动互联网的科技型教育服务平台。教予学采用学生线上预约、教师线下授课的方式，为教师和学生搭建教育供需平台。小初高学生可以在平台上预约教师，自主发布课程需求订单。教师可以自由设定授课时间，主动抢单。同时教予学建立了教师与学生间的信用体系，双方可匿名互评，极大地保障学生和教师双方权益。在信用体系基础上，教予学开创了按次付费的方式，结束了教育机构绑定消费的时代。教予学独有的”共享收益“、“共享地址”，让教育不再局限于“花钱补习”，也不再局限于“一席之地”，也打破了教育机构课程价格高昂、上课周期长、时间地点固定等传统。\n教予学按需授课的教育方式，全新的信用体系，按次付费的支付方式，低廉的课程价格，独有的“共享收益”、“共享地址”，让教育不再是负担，让教育回归本质。教予学将改变你的学习方式！找老师，找学生，就到教予学", nil);
    _addressExplainLabel.textColor = [UIColor colorWithHexString:@"#949494"];
    _addressExplainLabel.font = FONT_SIZE(14);
    _addressExplainLabel.numberOfLines = 0;
    [_addressExplainLabel sizeToFit];
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
