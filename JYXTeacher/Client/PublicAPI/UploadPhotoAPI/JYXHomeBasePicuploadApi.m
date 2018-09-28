//
//  JYXHomeBasePicuploadApi.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHomeBasePicuploadApi.h"

@implementation JYXHomeBasePicuploadApi
{
    NSArray *_files;
}

- (instancetype)initWithFile:(NSArray *)files
{
    self = [super init];
    if (self) {
        _files = files;
        self.validator = self;
    }
    
    return self;
}

//上传文件
- (UploadFormDataBlock)uploadFormDataBlock
{
    return ^(id<AFMultipartFormData> formData) {
        for (id mfile in _files) {
            NSData *data = nil;
            NSString *type = nil;
            NSString *fileName = nil;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat            = @"yyyyMMddHHmmss";
            NSString *str                   = [formatter stringFromDate:[NSDate date]];
            NSString *formKey = @"files";
            data = UIImageJPEGRepresentation(mfile, 0.5);
            type = @"image/png";
            fileName = [NSString stringWithFormat:@"%@.png", str];
            
            [formData appendPartWithFileData:data name:formKey fileName:fileName mimeType:type];
        }
    };
}

#pragma mark - RXAPIManagerParams
- (RXRequestMethod)methodName
{
    return RXRequestMethodPost;
}

- (RXRequestSerializerType)requestSerializerType
{
    return RXRequestSerializerTypeHTTP;
}

- (NSString *)detailUrl
{
    if (self.url.length > 0) {
        return self.url;
    }else{
        return @"home/base/picupload";
    }
}

- (NSDictionary *)requestParams:(NSDictionary *)param
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
    return dict;
}

#pragma mark - RXApiManagerDataReformer -
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data
{
    return data[@"result"];
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
            
            if ([data[@"result"] isKindOfClass:[NSDictionary class]]) {
                
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
