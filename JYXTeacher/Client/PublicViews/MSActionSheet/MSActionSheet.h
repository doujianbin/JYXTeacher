//
//  MSActionSheet.h
//  myshow-client
//
//  Created by Michael Ge on 16/1/13.
//  Copyright © 2016年 Beijing MaiXiu Interaction Technology Co., Ltd. All rights reserved.
//

#define MSActionSheetButtons(...) [NSArray arrayWithObjects:__VA_ARGS__, nil]

@class MSActionSheet;

/**
 ActionSheet 点击选项时的回调方法

 @param sheet    MSActionSheet 实例
 @param btnIndex 按钮索引，从 0 开始
 */
typedef void(^MSActionSheetActionHandle)(MSActionSheet *sheet,int btnIndex);
/**
 ActionSheet 点击取消时的回调方法
 
 @param sheet    MSActionSheet 实例
 */
typedef void(^MSActionSheetCancelHandle)(MSActionSheet *sheet);

@interface MSActionSheet : UIView
/**
 *  初始化方法
 *
 *  @param title   标题
 *  @param buttons 按钮标题，字符串类型(不含取消按钮）
 *  @param handler 按钮点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitleNoCancel:(NSString *)title
                              buttons:(NSArray *)buttons
                              handler:(MSActionSheetActionHandle)handler;

/**
 *  初始化方法
 *
 *  @param title   标题
 *  @param cancelHandler 取消按钮点击处理
 *  @param buttons 按钮标题，字符串类型(不含取消按钮）
 *  @param handler 按钮点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitleAndCancel:(NSString *)title
                         cancelHandler:(MSActionSheetCancelHandle)cancelHandler
                               buttons:(NSArray *)buttons
                               handler:(MSActionSheetActionHandle)handler;

/**
 *  初始化方法
 *
 *  @param title   标题
 *  @param cancel  取消按钮标题，如果传空则使用默认标题（取消）。
 *  @param cancelHandler 取消按钮点击处理
 *  @param buttons 按钮标题，字符串类型(不含取消按钮）
 *  @param handler 按钮点击处理(按钮索引从 0 开始)
 *
 *  @return return value description
 */
- (instancetype)initWithTitleAndCancel:(NSString *)title
                                cancel:(NSString *)cancel
                         cancelHandler:(MSActionSheetCancelHandle)cancelHandler
                               buttons:(NSArray *)buttons
                               handler:(MSActionSheetActionHandle)handler;
/**
 *  显示
 */
-(void)show;

/**
 *  关闭
 */
-(void)close;

#pragma mark - 内部方法，供子类重写
/**
 *  设置选择项（按钮）样式
 *
 *  @param button 选择项（按钮）
 */
//-(void)setButtonStyle:(MSButton *)button;

/**
 *  设置标题样式
 *
 *  @param label 标题框
 */
-(void)setTitleStyle:(UILabel *)label;

/**
 *  设置取消按钮样式
 *
 *  @param button 取消按钮
 */
//-(void)setCancelButtonStyle:(MSButton *)button;
@end
