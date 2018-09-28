//
//  JYXScheduleTopBarView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectYearBlock) (NSString *year);
typedef void (^SelectMonthBlock) (NSString *month);
@interface JYXScheduleTopBarView : UIView
@property (nonatomic, copy) SelectYearBlock yearBlock;
@property (nonatomic, copy) SelectMonthBlock monthBlock;
- (void)configScheduleViewWithData:(id)model;
@end
