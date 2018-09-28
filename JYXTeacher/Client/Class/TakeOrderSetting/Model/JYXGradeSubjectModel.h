//
//  JYXGradeSubjectModel.h
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JYXGradeSubjectChildrenModel : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, strong) NSNumber *isSelected;
@end

@interface JYXGradeSubjectModel : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, strong) NSNumber *isSelected;
@property (nonatomic, strong) NSArray <JYXGradeSubjectChildrenModel *>* children;
@end
