//
//  JYXSelectedGradeSubjectCollectionViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXSelectedGradeSubjectCollectionViewCell : UICollectionViewCell

+ (CGSize)cellWithTitle:(NSString *)title;
- (void)configSelectedGradeSubjectCellWithData:(id)model;
@end
