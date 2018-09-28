//
//  HSlider.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "HSlider.h"
@interface HSlider ()
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *scrollShowTextView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *scrollShowTextLabel;
@property (nonatomic,strong) UIView *touchView;
@property (nonatomic) CGFloat hMaxValue;
@end
@implementation HSlider



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setCurrentSliderValue:(CGFloat)currentSliderValue
{
    _currentSliderValue = currentSliderValue-15;
    
    _leftView.frame = CGRectMake(0, 0,_currentSliderValue / (_hMaxValue/self.frame.size.width), self.frame.size.height);
}

-(void)setShowTouchView:(BOOL)showTouchView{
    _showTouchView = showTouchView;
    if(_showTouchView){
        _touchView .frame = CGRectMake(0, 0, self.frame.size.height + 15, self.frame.size.height + 15);
        _touchView.center = _textLabel.center;
    }
    
}


-(void)setMaxValue:(CGFloat)maxValue{
    
    _hMaxValue = maxValue-15;
    
}

-(void)setCurrentValueColor:(UIColor *)currentValueColor{
    
    self.leftView.backgroundColor = currentValueColor;
}

-(void)setShowTextColor:(UIColor *)showTextColor
{
    _textLabel.textColor = showTextColor;
    _scrollShowTextLabel.textColor = showTextColor;
}

-(void)setTouchViewColor:(UIColor *)touchViewColor{
    _touchView.backgroundColor = touchViewColor;
}


- (void)setShowScrollTextView:(BOOL)showScrollTextView
{
    
    _showScrollTextView = showScrollTextView;
    
    self.scrollShowTextView.hidden = !showScrollTextView;
    self.scrollShowTextView.frame = CGRectMake((self.touchView.frame.origin.x)>= 0 ? (self.touchView.frame.origin.x):(0) ,- 38, 38, 27);

    if (roundf(self.currentSliderValue + 15) >= _hMaxValue) {
        self.scrollShowTextLabel.text = NSLocalizedString(@"不限", nil);
    } else {
        self.scrollShowTextLabel.text = [NSString stringWithFormat:@"%dKM",(int)(self.currentSliderValue + 15)];
    }
}

- (void)setup{
    
    
    self.layer.cornerRadius = self.frame.size.height/2;
    self.backgroundColor = [UIColor colorWithHex:0xd5d5d5];
    
    
    /** 显示文字label*/
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.font = [UIFont systemFontOfSize:9.0];
    _textLabel.textAlignment = NSTextAlignmentRight;
    [self.leftView addSubview:_textLabel];
    
    /** 数值视图*/
    _leftView = [[UIView alloc]init];
    _leftView.layer.cornerRadius = self.frame.size.height/2;
    _leftView.backgroundColor = [UIColor colorWithHex:0x18b2fd];
    [self addSubview:_leftView];
    
    _scrollShowTextView  = [[UIView alloc]init];
    _scrollShowTextView.hidden = YES;
    _scrollShowTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollShowTextView];
    
    
    /** 浮标image*/
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,38,27)];
    _imageView.image = [UIImage imageNamed:@"distanceBubble"];
    [_scrollShowTextView addSubview:_imageView];
    
    /** 浮标数值显示label*/
    _scrollShowTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 38, 20)];
    _scrollShowTextLabel.textAlignment = NSTextAlignmentCenter;
    _scrollShowTextLabel.textColor = [UIColor colorWithHex:0xa8a8a8];
    _scrollShowTextLabel.font = [UIFont systemFontOfSize:12.0];
    [_scrollShowTextView addSubview:_scrollShowTextLabel];
    
    
    /** 圆形触摸块*/
    _touchView  = [[UIView alloc]init];
    _touchView.layer.cornerRadius = (self.frame.size.height + 15) /2;
    _touchView.layer.masksToBounds = YES;
    _touchView.backgroundColor = [UIColor colorWithHex:0xe2e2e2];
    [self addSubview:_touchView];
    
    /** 默认最大值*/
    _hMaxValue = 100.0;
    
    UIPanGestureRecognizer *longGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(longGRAction:)];
    [_touchView addGestureRecognizer:longGR];
    
}

- (void)longGRAction:(UIPanGestureRecognizer *)recognizer{
    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        (!self.showScrollTextView) ? (self.scrollShowTextView.hidden = YES) : (self.scrollShowTextView.hidden = NO);
    }else{
        self.scrollShowTextView.hidden = NO;
        CGPoint translation            = [recognizer locationInView:self];
        
        
        if((translation.x >=0 && ((_hMaxValue/self.frame.size.width) * translation.x) <= _hMaxValue)){
            
            self.leftView.frame           = CGRectMake(0, 0, translation.x, self.frame.size.height);
            self.scrollShowTextView.frame = CGRectMake((translation.x-18)>= 0 ? (translation.x-18):(0) ,- 38, 38, 27);
            self.textLabel .frame             = CGRectMake((self.leftView.frame.size.width - 20) >= 0 ? (self.leftView.frame.size.width - 20):(0) , 0, 20, self.frame.size.height);
            self.textLabel.text           = [NSString stringWithFormat:@"%.f",(_hMaxValue/self.frame.size.width) * translation.x];
        
            if (roundf((_hMaxValue/self.frame.size.width) * translation.x) >= _hMaxValue) {
                self.scrollShowTextLabel.text = NSLocalizedString(@"不限", nil);
            } else {
                self.scrollShowTextLabel.text = [NSString stringWithFormat:@"%dKM",(int)((_hMaxValue/self.frame.size.width) * translation.x + 15)];
            }
            
            if(_showTouchView){
                _touchView .frame             = CGRectMake(0, 0, self.frame.size.height + 15, self.frame.size.height + 15);
                _touchView.center             = _textLabel.center;
            }
            
            
            /** delegate*/
            if([self.delegate respondsToSelector:@selector(HSlider:didScrollValue:)]){
                [self.delegate HSlider:self didScrollValue:((_hMaxValue/self.frame.size.width) * translation.x + 15)];
            }
            
            
        }
        
    }
}

@end
