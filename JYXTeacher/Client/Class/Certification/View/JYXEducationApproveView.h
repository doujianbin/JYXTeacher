//
//  JYXEducationApproveView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SubmitSuccessBlock) (void);
@interface JYXEducationApproveView : UIView
@property (nonatomic, copy) SubmitSuccessBlock submitSuccessBlock;
@end
