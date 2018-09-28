//
//  JYXHomeBasePicuploadApi.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "RXBaseRequest.h"

@interface JYXHomeBasePicuploadApi : RXBaseRequest<RXAPIManagerParams, RXAPIManagerValidator, RXApiManagerDataReformer>

/**
 上传图片

 @param files 图片文件
 @return JYXHomeBasePicuploadApi
 */
- (instancetype)initWithFile:(NSArray *)files;

@property (nonatomic,strong)NSString    *url;
@end
