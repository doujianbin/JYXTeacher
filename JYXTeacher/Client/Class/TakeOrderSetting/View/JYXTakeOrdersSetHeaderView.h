//
//  JYXTakeOrdersSetHeaderView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXTakeOrdersSetHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *jsonString;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *gradeSubjectSelectBgView;//授课年级科目选择
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIView *gradeSubjectBgView;//已选授课年级科目
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *emptyPageLabel;


- (void)configTakeOrdersSetHeaderView;
- (void)contentCellWithDataArr:(NSArray *)arr;
@end
