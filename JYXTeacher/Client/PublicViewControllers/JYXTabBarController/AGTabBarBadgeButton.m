//
//  AGTabBarBadgeButton.m
//  ArtGrade
//
//  Created by YXG on 2018/4/20.
//  Copyright © 2018年 AG. All rights reserved.
//

#import "AGTabBarBadgeButton.h"

@implementation AGTabBarBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundColor:[UIColor redColor]];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 9;
        self.titleLabel.font = [UIFont systemFontOfSize:9];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (_badgeValue && [_badgeValue integerValue] > 0) {
        
        if ([_badgeValue integerValue] >= 100) _badgeValue = @"99+";
        
        
        self.hidden = NO;
        // 设置文字
        [self setTitle:_badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = 18;
        CGFloat badgeW;
        
        if ([_badgeValue isEqualToString:@"99+"]){
            badgeW = 25;
        }else{
            badgeW = 18;
        }
        //        if (badgeValue.length > 1) {
        //            // 文字的尺寸
        //            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
        //            badgeW = badgeSize.width + 10;
        //        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    } else {
        
        self.hidden = YES;
    }
}

@end
