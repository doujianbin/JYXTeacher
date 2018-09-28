//
//  JYXTeachingMethodViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"
typedef void(^TeacherClassComplete)(void);
@interface JYXTeachingMethodViewController : JYXBaseViewController

@property (nonatomic ,strong)NSDictionary *dic_data;
@property (nonatomic ,copy  )TeacherClassComplete   teacherClassComplete;

@end

