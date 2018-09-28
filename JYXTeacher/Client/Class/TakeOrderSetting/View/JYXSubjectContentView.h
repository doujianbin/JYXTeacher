//
//  JYXSubjectContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectedSubjectBlock) (void);
@interface JYXSubjectContentView : UIView
@property (nonatomic, copy) SelectedSubjectBlock selectedSubjectBlock;
- (void)configSubjectViewWithData:(id)model;
@end
