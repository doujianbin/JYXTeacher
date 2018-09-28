//
//  JYXBaseViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXBaseViewController : UIViewController
@property (nonatomic, copy, readonly) NSMutableDictionary *parameter;
@property (nonatomic, copy, readonly) NSMutableDictionary *returnParameter;

/**
 给下一个页面传参：单向传递，下一页面可直接通过self.parameter获取参数。
 
 @param param <#param description#>
 */
- (void)setResult:(NSDictionary *)param;

/**
 *  显示导航栏左边Button:默认除一级页面没有
 *
 *  @param image png 图片
 */
- (void)setLeftBarButton:(NSString *)image;

/**
 *  显示导航栏右边Button:默认除一级页面没有
 *
 *  @param image png 图片
 */
- (void)setRightBarButton:(NSString *)image;

/**
 返回按钮的事件:默认pop上一级，子类可重写方法实现
 
 @param btn 返回按钮
 */
- (void)naviBack:(UIButton *)btn;
- (void)naviRight:(UIButton *)btn;

+ (UIViewController *)getCurrentVC;


@end
