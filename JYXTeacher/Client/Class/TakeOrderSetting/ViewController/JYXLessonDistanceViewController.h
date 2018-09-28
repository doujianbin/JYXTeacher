//
//  JYXLessonDistanceViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"
typedef void (^LessonDistanceBlock) (NSInteger range);
@interface JYXLessonDistanceViewController : JYXBaseViewController

@property (nonatomic, assign) NSInteger currentDistance;


@property (nonatomic, copy) LessonDistanceBlock lessonDistanceBlock;
@end

