//
//  JYXPayPenaltyViewController.m
//  JYXTeacher
//
//  Created by 窦建斌 on 2018/9/13.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXPayPenaltyViewController.h"
#import "UILabel+LineSpace.h"
#import "TeacherWorkHandler.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JYXWorkHomeViewController.h"
#import <UMCAnalytics/UMAnalytics/MobClick.h>

@interface JYXPayPenaltyViewController ()<WXApiManagerDelegate>

@property (nonatomic ,strong)UIButton  *btn_selWechat;
@property (nonatomic ,strong)UIButton  *btn_selAlipay;
@property (nonatomic ,strong)UIButton  *btn_selYinLian;
@property (nonatomic ,strong)NSString  *paytype;         //1支付宝2微信3银联
@property (nonatomic ,strong)UILabel   *lb_money;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation JYXPayPenaltyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缴纳罚金";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [WXApiManager sharedManager].delegate = self;
    [self onCreate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPaySuccess) name:NF_WECHAT_PAY_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPaySuccess) name:NF_ALIPAY_PAY_SUCCESS object:nil];
}

- (void)onCreate{

    self.paytype = @"1";
    UIView * v_titleBack = [[UIView alloc]initWithFrame:CGRectMake(8, 4, SCREEN_WIDTH - 16, 90)];
    [self.view addSubview:v_titleBack];
    [v_titleBack setBackgroundColor:[UIColor clearColor]];
    v_titleBack.layer.borderWidth = 1.0f;
    v_titleBack.layer.cornerRadius = 5;
    v_titleBack.layer.borderColor = [[UIColor colorWithHexString:@"#C2C2C2"] CGColor];
    v_titleBack.layer.masksToBounds = YES;
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 45)];
    [v_titleBack addSubview:lb1];
    [lb1 setText:@"需要缴纳罚金:"];
    [lb1 setTextColor:[UIColor colorWithHexString:@"#797979"]];
    lb1.font = [UIFont systemFontOfSize:15];
    
    self.lb_money = [[UILabel alloc]initWithFrame:CGRectMake(lb1.right + 10, lb1.top, 200, lb1.height)];
    [v_titleBack addSubview:self.lb_money];
    [self.lb_money setText:self.str_penalty];
    [self.lb_money setTextColor:[UIColor colorWithHexString:@"#797979"]];
    [self.lb_money setFont:[UIFont systemFontOfSize:15]];
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, v_titleBack.width, 0.5)];
    [v_titleBack addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 100, 45)];
    [v_titleBack addSubview:lb2];
    [lb2 setText:@"产生原因:"];
    [lb2 setTextColor:[UIColor colorWithHexString:@"#797979"]];
    lb2.font = [UIFont systemFontOfSize:15];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(46, v_titleBack.bottom + 32, 100, 15)];
    [self.view addSubview:lb3];
    [lb3 setText:@"选择支付方式"];
    [lb3 setTextColor:[UIColor colorWithHexString:@"#777777"]];
    lb3.font = [UIFont systemFontOfSize:15];
    
    UIButton *btn_alipay = [[UIButton alloc]initWithFrame:CGRectMake(44, lb3.bottom + 21, 36, 36)];
    [self.view addSubview:btn_alipay];
    [btn_alipay setBackgroundImage:[UIImage imageNamed:@"alipay"] forState:UIControlStateNormal];
    [btn_alipay addTarget:self action:@selector(btn_alipyAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_wechat = [[UIButton alloc]initWithFrame:CGRectMake(btn_alipay.right + 89, lb3.bottom + 21, 36, 36)];
    [self.view addSubview:btn_wechat];
    [btn_wechat setBackgroundImage:[UIImage imageNamed:@"wechatPay"] forState:UIControlStateNormal];
    [btn_wechat addTarget:self action:@selector(btn_wechatAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_yinlian = [[UIButton alloc]initWithFrame:CGRectMake(btn_wechat.right + 89, lb3.bottom + 21, 36, 36)];
    [self.view addSubview:btn_yinlian];
    [btn_yinlian setBackgroundImage:[UIImage imageNamed:@"unionPay"] forState:UIControlStateNormal];
    [btn_yinlian addTarget:self action:@selector(btn_yinlianAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_selAlipay = [[UIButton alloc]initWithFrame:CGRectMake(35, btn_alipay.bottom + 19, 58, 14)];
    [self.view addSubview:self.btn_selAlipay];
    [self.btn_selAlipay setTitle:@"支付宝" forState:UIControlStateNormal];
    [self.btn_selAlipay setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.btn_selAlipay setTitleColor:[UIColor colorWithHexString:@"#7D7D7D"] forState:UIControlStateNormal];
    self.btn_selAlipay.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.btn_selAlipay sizeToFit];
    [self.btn_selAlipay setImageEdgeInsets:UIEdgeInsetsMake(0.0, -4, 0.0, 0.0)];
    [self.btn_selAlipay addTarget:self action:@selector(btn_alipyAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_selWechat = [[UIButton alloc]initWithFrame:CGRectMake(160, btn_wechat.bottom + 19, 58, 14)];
    [self.view addSubview:self.btn_selWechat];
    [self.btn_selWechat setTitle:@"微信" forState:UIControlStateNormal];
    [self.btn_selWechat setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    [self.btn_selWechat setTitleColor:[UIColor colorWithHexString:@"#7D7D7D"] forState:UIControlStateNormal];
    self.btn_selWechat.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_selWechat setImageEdgeInsets:UIEdgeInsetsMake(0.0, -4, 0.0, 0.0)];
    [self.btn_selWechat addTarget:self action:@selector(btn_wechatAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_selYinLian = [[UIButton alloc]initWithFrame:CGRectMake(285, btn_yinlian.bottom + 19, 58, 14)];
    [self.view addSubview:self.btn_selYinLian];
    [self.btn_selYinLian setTitle:@"银联" forState:UIControlStateNormal];
    [self.btn_selYinLian setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    [self.btn_selYinLian setTitleColor:[UIColor colorWithHexString:@"#7D7D7D"] forState:UIControlStateNormal];
    self.btn_selYinLian.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_selYinLian setImageEdgeInsets:UIEdgeInsetsMake(0.0, -4, 0.0, 0.0)];
    [self.btn_selYinLian addTarget:self action:@selector(btn_yinlianAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *btn_tijiao = [[UIButton alloc] init];
    [self.view addSubview:btn_tijiao];
    btn_tijiao.frame = CGRectMake(18,self.btn_selWechat.bottom + 34,SCREEN_WIDTH - 36,48);
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 34, 46);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#13BDFB"] CGColor],(id)[[UIColor colorWithHexString:@"#1EA3FF"] CGColor]]];//渐变数组
    [btn_tijiao.layer addSublayer:gradientLayer];
    
    btn_tijiao.layer.cornerRadius = 5;
    btn_tijiao.layer.masksToBounds = YES;
    [btn_tijiao setTitle:@"去 支 付" forState:UIControlStateNormal];
    btn_tijiao.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [btn_tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_tijiao addTarget:self action:@selector(btn_tijiaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lb_detail = [[UILabel alloc]initWithFrame:CGRectMake(45, btn_tijiao.bottom + 26, SCREEN_WIDTH - 90, 190)];
    [self.view addSubview:lb_detail];
    [lb_detail setTextColor:[UIColor colorWithHexString:@"#595959"]];
    [lb_detail setFont:[UIFont systemFontOfSize:13]];
    NSString *str_detail = @"罚金缴纳说明\n1.出现由于爽约、差评等投诉产生的罚金，由平台直接从教师余额中直接扣除。\n2.如余额不足以抵扣相应罚金，则需要通过钱包-课时费的相关链接进行自主缴纳罚金后，方可正常开始授课。\n3.自未缴纳罚金起，教师信息将无法正常出现在平台上，也无法正常授课，已约课程需正常授课，并由后台自主从后续所得课时费中自动扣除相应罚金，直到账户恢复正常。";
    [lb_detail setSpaceJustifiedLabelHeightWithText:str_detail withWidth:SCREEN_WIDTH - 90];
    
    
}

- (void)btn_wechatAction{
    self.paytype = @"2";
    [self.btn_selWechat setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.btn_selAlipay setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    [self.btn_selYinLian setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    
}

- (void)btn_alipyAction{
    self.paytype = @"1";
    [self.btn_selAlipay setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.btn_selWechat setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    [self.btn_selYinLian setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
}

- (void)btn_yinlianAction{
    self.paytype = @"3";
    [self.btn_selYinLian setImage:[UIImage imageNamed:@"paymentBtn_Sel"] forState:UIControlStateNormal];
    [self.btn_selAlipay setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    [self.btn_selWechat setImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
}

- (void)btn_tijiaoAction{
    if ([self.paytype isEqualToString:@"1"]) {
        [TeacherWorkHandler teacherpayforWithPaytype:self.paytype money:self.str_penalty prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            [[AlipaySDK defaultService] payOrder:dic[@"info"] fromScheme:@"aweakZhifubao" callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000) {
                    [MBProgressHUD showSuccessMessage:@"支付成功"];
                    JYXWorkHomeViewController *vc = [[JYXWorkHomeViewController alloc] init];
                    self.window.rootViewController = vc;
                }
            }];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
        
    }else if ([self.paytype isEqualToString:@"3"]){
        [MobClick event:@"yinliandianji"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"我们正在加紧开通银联支付，给您造成不便敬请谅解\n可以尝试使用微信支付或者支付宝" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [TeacherWorkHandler teacherpayforWithPaytype:self.paytype money:self.str_penalty prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            [self weiXinPayWithDic:dic];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }
}

- (void)weiXinPayWithDic:(NSDictionary *)wechatPayDic {
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = [wechatPayDic objectForKey:@"partnerid"];
    req.prepayId = [wechatPayDic objectForKey:@"prepayid"];
    req.package = [wechatPayDic objectForKey:@"package"];
    req.nonceStr = [wechatPayDic objectForKey:@"noncestr"];
    req.timeStamp = [[wechatPayDic objectForKey:@"timestamp"] intValue];
    req.sign = [wechatPayDic objectForKey:@"sign"];
    [WXApi sendReq:req];
}

- (void)weChatPaySuccess{
    [MBProgressHUD showSuccessMessage:@"缴纳成功"];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
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
