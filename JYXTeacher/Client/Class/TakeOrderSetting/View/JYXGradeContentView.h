//
//  JYXGradeContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectedGradeBlock) (id model);
@interface JYXGradeContentView : UIView
@property (nonatomic, copy) SelectedGradeBlock selectedGradeBlock;
- (void)configGradeViewWithData:(id)model;
- (void)refreshGradeData;
@end
