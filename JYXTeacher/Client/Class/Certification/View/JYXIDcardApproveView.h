//
//  JYXIDcardApproveView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SubmitSuccessBlock) (void);
@interface JYXIDcardApproveView : UIView
@property (nonatomic, copy) SubmitSuccessBlock submitSuccessBlock;
@property (nonatomic ,strong) NSString *teacherType;

@end
