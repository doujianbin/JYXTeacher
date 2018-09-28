//
//  PGDatePicker+Month.h
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "PGDatePicker.h"

@interface PGDatePicker (Month)
- (void)month_setupSelectedDate;
- (void)month_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated;
@end
