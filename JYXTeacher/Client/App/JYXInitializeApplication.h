//
//  JYXInitializeApplication.h
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYXInitializeApplication : NSObject

+ (UIViewController *)initialize:(UIApplication *)application
                         options:(NSDictionary *)launchOptions;

@end
