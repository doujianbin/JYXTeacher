//
//  JYXWaitLessonHeaderView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DateSelectSuccess) (NSString *selectedDate);
@interface JYXWaitLessonHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) DateSelectSuccess dateSelectSuccess;
- (void)configWaitLessonHeaderViewWithData:(id)model;
@end
