//
//  JYXCertificationMaterialsTableViewCell.h
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXCertificationMaterialsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *helpImg;
@property (nonatomic, strong) UIButton *btn_help;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *arrowImg;


- (void)configCertificationMaterialsCellWithData:(id)model;
@end
