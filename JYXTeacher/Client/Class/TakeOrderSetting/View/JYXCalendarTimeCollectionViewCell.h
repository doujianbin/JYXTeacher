//
//  JYXCalendarTimeCollectionViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXCalendarTimeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configCalendarTimeLabelCellWithData:(id)model;

@end
