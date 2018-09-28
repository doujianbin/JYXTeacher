//
//  PGDatePicker+Month.m
//  JYXTeacher
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "PGDatePicker+Month.h"
#import "PGDatePickerHeader.h"

@implementation PGDatePicker (Month)
- (void)month_setupSelectedDate {
    NSString *monthString = [self.pickerView textOfSelectedRowInComponent:0];
    monthString = [monthString componentsSeparatedByString:self.monthString].firstObject;
    self.selectedComponents.month = [monthString integerValue];
}

- (void)month_setDateWithComponents:(NSDateComponents *)components animated:(BOOL)animated {
    if (components.month > self.maximumComponents.month) {
        components.month = self.maximumComponents.month;
    }else if (components.month < self.minimumComponents.month) {
        components.month = self.minimumComponents.month;
    }
    NSInteger row = components.month - self.minimumComponents.month;
    [self.pickerView selectRow:row inComponent:0 animated:animated];
}

@end
