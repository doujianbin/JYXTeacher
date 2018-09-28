//
//  JYXCourseDetailViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"

@interface JYXCourseDetailViewController : JYXBaseViewController
@property (nonatomic, strong) NSNumber *courseType;//0.待上课1.已上课2.抢单
@property (nonatomic, strong) NSNumber *courseId;//课程ID
@end
