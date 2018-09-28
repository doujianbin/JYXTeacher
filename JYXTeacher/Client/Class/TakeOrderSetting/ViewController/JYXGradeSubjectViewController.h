//
//  JYXGradeSubjectViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"
typedef void(^SelectedGradeSubjectBlock)(NSArray *array, NSString *jsonString);
@interface JYXGradeSubjectViewController : JYXBaseViewController
@property (nonatomic, copy) SelectedGradeSubjectBlock selectedGradeSubjectBlock;
@end
