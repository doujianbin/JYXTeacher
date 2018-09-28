//
//  JYXAddEditSpecialtyApproveViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"
typedef enum {
    SpecialtyApproveAdd = 1,
    SpecialtyApproveEdit
}SpecialtyApprove;

@interface JYXAddEditSpecialtyApproveViewController : JYXBaseViewController
@property (nonatomic, assign) SpecialtyApprove specialtyApprove;
@end
