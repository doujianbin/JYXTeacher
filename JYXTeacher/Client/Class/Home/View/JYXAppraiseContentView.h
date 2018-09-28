//
//  JYXAppraiseContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SubmitAppraiseBlock) (NSDictionary *dict);
@interface JYXAppraiseContentView : UIView

@property (nonatomic, copy) SubmitAppraiseBlock submitAppraiseBlock;
- (void)configAppraiseViewWithData:(id)model;

@end
