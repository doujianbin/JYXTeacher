//
//  JYXGradeSubjectCollectionViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXGradeSubjectCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configGradeSubjectCellWithData:(id)model;
@end
