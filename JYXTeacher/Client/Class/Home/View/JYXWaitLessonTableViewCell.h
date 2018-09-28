//
//  JYXWaitLessonTableViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DeleteCellBlock) (NSDictionary *dict);
@interface JYXWaitLessonTableViewCell : UITableViewCell
@property (nonatomic, copy) DeleteCellBlock deleteCellBlock;
- (void)configWaitLessonCellWithData:(id)model;
@end
