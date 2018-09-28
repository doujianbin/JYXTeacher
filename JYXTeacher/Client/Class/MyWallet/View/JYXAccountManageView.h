//
//  JYXAccountManageView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXAccountManageView : UIView
@property (nonatomic, copy) UIImage *iconImg;
@property (nonatomic, copy) NSString *placeholderStr;
@property (nonatomic, copy) NSString *accountStr;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UITextField *accountField;
@end
