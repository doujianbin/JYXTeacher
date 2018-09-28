//
//  JYXCourseHomeworkContentView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReleaseHomeworkBlock) (NSDictionary *dict);
@interface JYXCourseHomeworkContentView : UIView
@property (nonatomic, copy) ReleaseHomeworkBlock releaseHomeworkBlock;
@property (nonatomic, strong) NSString *title;
@end
