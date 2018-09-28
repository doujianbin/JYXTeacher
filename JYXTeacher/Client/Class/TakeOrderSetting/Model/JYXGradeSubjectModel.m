//
//  JYXGradeSubjectModel.m
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXGradeSubjectModel.h"
@implementation JYXGradeSubjectChildrenModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"value" : @"value",
             @"label" : @"label",
             @"isSelected" : @"isSelected"
             };
}

@end

@implementation JYXGradeSubjectModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"value" : @"value",
             @"label" : @"label",
             @"isSelected" : @"isSelected",
             @"children" : @"children"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"children" : @"JYXGradeSubjectChildrenModel"};
}
@end
