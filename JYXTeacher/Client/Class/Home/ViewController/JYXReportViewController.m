//
//  JYXReportViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/12.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXReportViewController.h"
#import "TeacherWorkHandler.h"

@interface JYXReportViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;

@end

@implementation JYXReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"举报";
    [self oncreate];
}

- (void)oncreate{
    
    _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(17, 19, SCREEN_WIDTH - 34, 150)];
    [self.view addSubview:_contentTextView];
    JYXViewBorderRadius(_contentTextView, 10, 1, [UIColor colorWithHex:0xc1c1c1]);
    _contentTextView.placeholder = NSLocalizedString(@"请输入举报内容必填", nil);
    _contentTextView.font = FONT_SIZE(12);
    _contentTextView.delegate = self;
    _contentTextView.textColor = [UIColor colorWithHex:0x6d6d6d];
    _contentTextView.contentInset = EdgeInsets(10, 10, 20, 10);
    
    
    _wordNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 23 - 115, 120, 80, 13)];
    [_contentTextView addSubview:_wordNumberLabel];
    _wordNumberLabel.font = FONT_SIZE(13);
    _wordNumberLabel.text = @"0/300";
    _wordNumberLabel.textAlignment = NSTextAlignmentRight;
    _wordNumberLabel.textColor = [UIColor colorWithHexString:@"#C1C1C1"];
//    [_wordNumberLabel sizeToFit];
    
    
    UIButton *btn_tijiao = [[UIButton alloc] init];
    [self.view addSubview:btn_tijiao];
    btn_tijiao.frame = CGRectMake(17,_contentTextView.bottom + 87,SCREEN_WIDTH - 34,46);
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 34, 46);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#13BDFB"] CGColor],(id)[[UIColor colorWithHexString:@"#1EA3FF"] CGColor]]];//渐变数组
    [btn_tijiao.layer addSublayer:gradientLayer];
    
    btn_tijiao.layer.cornerRadius = 5;
    btn_tijiao.layer.masksToBounds = YES;
    [btn_tijiao setTitle:@"提交" forState:UIControlStateNormal];
    [btn_tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_tijiao addTarget:self action:@selector(btn_tijiaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, SCREEN_WIDTH, 12)];
    [self.view addSubview:lb1];
    [lb1 setText:@"使用过程中遇到任何问题请致电"];
    [lb1 setTextColor:[UIColor colorWithHexString:@"#ABABAB"]];
    [lb1 setFont:[UIFont systemFontOfSize:12]];
    [lb1 setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *btn_tell = [[UIButton alloc]initWithFrame:CGRectMake(0, lb1.bottom, SCREEN_WIDTH, 29)];
    [self.view addSubview:btn_tell];
    [btn_tell setTitle:@"010-57214966" forState:UIControlStateNormal];
    [btn_tell setTitleColor:[UIColor colorWithHexString:@"#6A6A6A"] forState:UIControlStateNormal];
    btn_tell.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_tell addTarget:self action:@selector(btn_tellAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn_tell.bottom, SCREEN_WIDTH, 12)];
    [self.view addSubview:lb2];
    [lb2 setText:@"工作日 09：00-17：00"];
    [lb2 setTextColor:[UIColor colorWithHexString:@"#ABABAB"]];
    [lb2 setFont:[UIFont systemFontOfSize:11]];
    [lb2 setTextAlignment:NSTextAlignmentCenter];

}

- (void)btn_tellAction{
    
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:010-57214966"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)btn_tijiaoAction{
    if ([_contentTextView.text isEqualToString:@""]) {
        [MBProgressHUD showErrorMessage:@"请填写举报内容"];
        return;
    }
    [TeacherWorkHandler teacherReportWithPhone:self.dic_data[@"teacherPhone"] targetphone:[[[self.dic_data objectForKey:@"studentData"] objectAtIndex:0] objectForKey:@"phone"] targettype:2 content:_contentTextView.text prepare:^{
        
    } success:^(id obj) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccessMessage:@"举报成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    } else {
        
        if (textView.text.length - range.length + text.length > 300) {
            [WLToast show:@"不能超过300个字"];
            return NO;
        } else {
            return YES;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
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
