//
//  JYXEditAddressViewController.h
//  JYXTeacher
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXBaseViewController.h"
typedef void (^AddressEditBlock) (NSString *detailAddress, NSString *latitude, NSString *longitude);
@interface JYXEditAddressViewController : JYXBaseViewController
@property (nonatomic, copy) AddressEditBlock addressEditBlock;
@end
