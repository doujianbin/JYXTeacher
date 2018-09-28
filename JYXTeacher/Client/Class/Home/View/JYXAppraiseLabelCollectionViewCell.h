//
//  JYXAppraiseLabelCollectionViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXAppraiseLabelCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configAppraiseLabelCellWithData:(id)model;
+ (CGSize)cellWithTitle:(NSDictionary *)dict;
@end
