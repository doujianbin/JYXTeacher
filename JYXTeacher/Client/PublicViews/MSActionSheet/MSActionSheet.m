//
//  MSActionSheet.m
//  myshow-client
//
//  Created by Michael Ge on 16/1/13.
//  Copyright © 2016年 Beijing MaiXiu Interaction Technology Co., Ltd. All rights reserved.
//

#import "MSActionSheet.h"
//#import "MSFontDefine.h"
//#import "MSColorDefine.h"

#define kDefaultCancelGap           6 //取消按钮与其它按钮的间距

#define kDefaultButtonLRMargin      0 //对话框与屏幕左右间距
#define kDefaultButtonGap           0.5  //按钮间间距
#define kDefaultButtonHeight        45 //按钮高度

#define kDefaultTitleHeight         45

#define kDefaultTopMargin           10;
#define kDefaultBottomMargin        0;

@interface MSActionSheet()
@property(nonatomic,copy) MSActionSheetCancelHandle cancelHandler;
@property(nonatomic,copy )MSActionSheetActionHandle actionHandler;
@end

@implementation MSActionSheet
{
    UIView   *mDefaultParentView;
    UIView   *mDialogBox;
    
    NSString *mCancelTitle;
    UIButton *mCancelView;
    
    NSString *mTitle;
    UILabel  *mTitleLabel;
    
    NSArray  *mButtonsTitle;
    NSMutableArray *mButtonsView;
    
    UIControl *mControl;
}

-(void)dealloc
{
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
    NSLog(@"ActionSheet Destory");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initActionSheet];
        mCancelTitle = @"取消";
        [self createSubView];
    }
    return self;
}

- (instancetype)initWithTitleNoCancel:(NSString *)title
                              buttons:(NSArray *)buttons
                              handler:(MSActionSheetActionHandle)handler
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initActionSheet];
        
        mTitle   = title;
        mButtonsTitle = buttons;
        self.actionHandler = handler;
        
        [self createSubView];
    }
    return self;
}

- (instancetype)initWithTitleAndCancel:(NSString *)title
                         cancelHandler:(MSActionSheetCancelHandle)cancelHandler
                               buttons:(NSArray *)buttons
                               handler:(MSActionSheetActionHandle)handler
{
    return [self initWithTitleAndCancel:title cancel:nil cancelHandler:cancelHandler buttons:buttons handler:handler];
}

- (instancetype)initWithTitleAndCancel:(NSString *)title
                                cancel:(NSString *)cancel
                         cancelHandler:(MSActionSheetCancelHandle)cancelHandler
                               buttons:(NSArray *)buttons
                               handler:(MSActionSheetActionHandle)handler
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self initActionSheet];
        
        mCancelTitle = cancel ? cancel : @"取消";
        mTitle       = title;
        mButtonsTitle= buttons;
        self.actionHandler = handler;
        self.cancelHandler = cancelHandler;
        
        [self createSubView];
    }
    
    return self;
}

-(void)show
{
    [self showWithSuperView:nil];
}

-(void)close
{
    //使用完将block设为nil 这样对象才会释放
    self.cancelHandler = nil;
    self.actionHandler = nil;
    [self hidenAnimation:0.3];
}

#pragma mark - 私有方法
-(void)showWithSuperView:(UIView *)view
{
    if (!view ) {
        view = mDefaultParentView;
    }
    
    //设置对框画布大小
    [self setFrame:[view bounds]];
    [mControl setFrame:[view bounds]];
    
    [view addSubview:self];
    
    [self layout];
    
    [self showAnimation:0.3];
}

-(void)initActionSheet
{
    mButtonsView = [NSMutableArray array];
    self.backgroundColor = [UIColor clearColor];
    
    mDialogBox = [[UIView alloc] init];
    mDialogBox.backgroundColor = [UIColor clearColor];
    
    //对话框默认显在窗口上
    mDefaultParentView = [UIApplication sharedApplication].keyWindow;
    
    mControl = [[UIControl alloc] initWithFrame:self.frame];
    [mControl addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mControl];
}

-(void)createSubView
{
    if (![NSString isEmpty:mTitle]){
        mTitleLabel = [[UILabel alloc]init];
        mTitleLabel.text = mTitle;
        
        [self setTitleStyle:mTitleLabel];
        mTitleLabel.font = FONT_SIZE(13);
        [mDialogBox addSubview:mTitleLabel];
    }
    
    //创建取消按钮
    if (mCancelTitle){
        mCancelView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [mCancelView addTarget:self
                        action:@selector(handleCancel)
              forControlEvents:UIControlEventTouchUpInside];
        
        [mCancelView setTag:0];
        [mCancelView setTitle:mCancelTitle
                     forState:UIControlStateNormal];
        
        [self setCancelButtonStyle:mCancelView];
        [mDialogBox addSubview:mCancelView];
    }
    
    if (!mButtonsTitle) {
        return;
    }
    
    for (int i = 0,count = (int)[mButtonsTitle count]; i < count; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(handleButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [button setTag:i];
        [button setTitle:mButtonsTitle[i]
                forState:UIControlStateNormal];
        
        [self setButtonStyle:button];
        
        [mButtonsView addObject:button];
        [mDialogBox addSubview:button];
    }
    
    [self addSubview:mDialogBox];
}

/**
 *  当 View 添加到父窗口时系统调用此方法进行View 布局
 */
-(void)layout
{
    float w = self.superview.width;
    float y = 0;
    
    float cellWidth  = w - kDefaultButtonLRMargin * 2;
    float cellHeight = kDefaultButtonHeight;
    
    int cellIndex = 0;
    
    //计算 Cell 总数
//    int cellCount = (mButtonsTitle ? (int)mButtonsTitle.count : 0) + (mTitle ? 1 : 0);
    
    y = kDefaultTopMargin;
    
    //标题布局
    if (mTitleLabel) {
        
        mTitleLabel.frame = CGRectMake(kDefaultButtonLRMargin,
                                       y,
                                       w - kDefaultButtonLRMargin * 2,
                                       kDefaultTitleHeight);
//        [self setCellRoundCorner:cellIndex count:cellCount view:mTitleLabel];
        
        y += mTitleLabel.frame.size.height;
        
        cellIndex ++;
    }
    
    //普通按钮布局
    int btnCount = mButtonsView ? (int)[mButtonsView count] : 0 ;
    for (int i = 0; i < btnCount; i++){
        UIButton *button = mButtonsView[i];
        y += kDefaultButtonGap;
        
        button.frame = CGRectMake(kDefaultButtonLRMargin,
                                  y,
                                  cellWidth,
                                  cellHeight);
        
//        [self setCellRoundCorner:cellIndex count:cellCount view:button];
        
        y += button.frame.size.height;
        
        cellIndex ++;
    }
    
    //取消按钮
    if (mCancelView) {
        y += kDefaultCancelGap;
        mCancelView.frame = CGRectMake(kDefaultButtonLRMargin,
                                       y,
                                       cellWidth,
                                       cellHeight);
        
//        [self setCellRoundCorner:0 count:0 view:mCancelView];
        
        y += mCancelView.frame.size.height;
        
        cellIndex ++;
    }
    
    y += kDefaultBottomMargin;
    
    //将对话框移动到视图底部
    mDialogBox.frame = CGRectMake(0,
                                  self.bounds.size.height,
                                  w,
                                  y);
}

-(void)setCellRoundCorner:(int)index count:(int)count view:(UIView*)view
{
    UIBezierPath *maskPath;
    UIRectCorner corner = 0;
    
    if (index >0 && index < count -1){
        return;
    }
    
    if (index == 0){
        //topRoundCorner
        corner = UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    
    if (index == count -1){
        //bottomRoundCorner
        corner |= UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:corner
                                           cornerRadii:CGSizeMake(2.5, 2.5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = mDialogBox.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - button action method
-(void)handleCancel
{
    if (self.cancelHandler){
        self.cancelHandler(self);
    }
    
    //关闭对话框
    [self close];
}

-(void)handleButton:(UIButton*)sender
{
    if (self.actionHandler){
        self.actionHandler(self,(int)sender.tag);
    }
    
    //关闭对话框
    [self close];
}

#pragma mark - 重写父类方法
//显示时动画
-(void)showAnimation:(float)timer
{
    [UIView animateWithDuration:timer animations:^{
        mDialogBox.frame = CGRectMake(0,
                                      self.frame.size.height-mDialogBox.frame.size.height-kAddBottomHeight,
                                      mDialogBox.frame.size.width,
                                      mDialogBox.frame.size.height);
        
        self.backgroundColor = [UIColor colorWithRed:0
                                               green:0
                                                blue:0
                                               alpha:0.8];
    }];
}

//隐藏时动画
-(void)hidenAnimation:(float)timer
{
    [UIView animateWithDuration:timer animations:^{
        mDialogBox.frame = CGRectMake(0,
                                      self.frame.size.height,
                                      mDialogBox.frame.size.width,
                                      mDialogBox.frame.size.height);
        self.backgroundColor = [UIColor colorWithRed:0
                                               green:0
                                                blue:0
                                               alpha:0.0];
    } completion:^(BOOL finished) {
        //动画完成从父视图移除 释放
        [self removeFromSuperview];
    }];
}

/**
 *  设置选择项（按钮）样式
 *
 *  @param button 选择项（按钮）
 */
-(void)setButtonStyle:(UIButton *)button
{
    [button setTitleColor:[UIColor colorWithHex:0x33333]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:0xff5252]
                 forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]
                      forState:UIControlStateHighlighted];
    
    [button.titleLabel setFont:FONT_SIZE(17)];
}

/**
 *  设置标题颜色
 *
 *  @param label 标题框
 */
-(void)setTitleStyle:(UILabel *)label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_SIZE(13);
    label.textColor = [UIColor colorWithHex:0x999999];
    label.backgroundColor = [UIColor whiteColor];
}

/**
 *  设置取消按钮颜色
 *
 *  @param button 取消按钮
 */
-(void)setCancelButtonStyle:(UIButton *)button
{
    [button setTitleColor:[UIColor colorWithHex:0x333333]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:0x333333]
                 forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]
                      forState:UIControlStateHighlighted];
    
    [button.titleLabel setFont:FONT_SIZE(17)];
}
@end
