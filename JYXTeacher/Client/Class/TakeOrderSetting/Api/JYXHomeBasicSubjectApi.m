//
//  JYXHomeBasicSubjectApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeBasicSubjectApi.h"
#import "JYXGradeSubjectModel.h"

@implementation JYXHomeBasicSubjectApi

- (nonnull instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - RXAPIManagerParams
- (RXRequestMethod)methodName
{
    return RXRequestMethodPost;
}

- (NSString *)detailUrl
{
    return @"home/basic/subject";
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:param];
    return dictM;
}

#pragma mark - RXApiManagerDataReformer -
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data
{
    NSArray *array = [JYXGradeSubjectModel mj_objectArrayWithKeyValuesArray:data[@"result"]];
    return array;
}

#pragma mark - RXAPIManagerValidator
- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *business = data[@"code"];
        if (business.intValue == 1000) {
            
            if ([data[@"result"] isKindOfClass:[NSArray class]]) {
                
                return YES;
            }
        } else {
            [WLToast show:data[@"msg"]];
            return NO;
        }
    }
    return NO;
}

@end
