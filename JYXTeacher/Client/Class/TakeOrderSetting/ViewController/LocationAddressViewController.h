//
//  LocationAddressViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "JYXBaseViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void(^goBackAddress)(AMapPOI *poiEntity);
@interface LocationAddressViewController : JYXBaseViewController

@property (nonatomic, copy  ) goBackAddress  goBackAddress;
@property (nonatomic ,strong) NSString *str_city;

@end
