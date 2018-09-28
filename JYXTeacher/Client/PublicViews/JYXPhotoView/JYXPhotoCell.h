//
//  JYXPhotoCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXPhotoCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;
@end
