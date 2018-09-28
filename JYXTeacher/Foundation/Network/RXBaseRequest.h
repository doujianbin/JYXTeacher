//
//  RXBaseRequest.h
//  Copyright © 2015年 Xuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "RXURLResponse.h"

typedef NS_ENUM(NSInteger, RXRequestMethod) {
    RXRequestMethodGet = 0,
    RXRequestMethodPost,
};

///  Request serializer type.
typedef NS_ENUM(NSInteger, RXRequestSerializerType) {
    RXRequestSerializerTypeHTTP = 0,
    RXRequestSerializerTypeJSON,
};


typedef NS_ENUM (NSUInteger, RXAPIManagerErrorType) {
   RXAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
   RXAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
   RXAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
   RXAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
   RXAPIManagerErrorTypeTimeout,       //请求超时。CTAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看CTAPIProxy的相关代码。
   RXAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

FOUNDATION_EXPORT NSString *RXStringFromAPIManagerErrorType(RXAPIManagerErrorType type);


@class RXBaseRequest;
typedef void (^UploadFormDataBlock)(id <AFMultipartFormData>formData);
typedef void(^RXRequestCompletionBlock)(__kindof RXBaseRequest *request);


/*
 所有的callback数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。
 因为判断逻辑都在这里做掉了。
 */
@protocol RXAPIManagerValidator <NSObject>

@required
/** 服务器返回参数的验证
 
   只需验证entity是否是你需要的数据即可
 */
- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithCallBackData:(NSDictionary *)data;
/** 前端请求参数的验证 */
- (BOOL)requestManager:(RXBaseRequest *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end

/** 请求参数配置 */
@protocol RXAPIManagerParams <NSObject>

@required
/// 请求的URL
- (NSString *)detailUrl;
/// 请求的方式
- (RXRequestMethod)methodName;

@optional

/**
 请求参数配置

 @param param 默认参数
 @return 完整参数配置
 */
- (id)requestParams:(NSDictionary *)param;
/// POST的上传文件
- (UploadFormDataBlock)uploadFormDataBlock;

@end

/** 数据重组：返回你需要的类型的数据 */
@protocol RXApiManagerDataReformer <NSObject>

@required
- (id)requestManager:(RXBaseRequest *)manager reformData:(NSDictionary *)data;

@end



@interface RXBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, weak) id <RXAPIManagerValidator> validator;

/**
 子类
 */
@property (nonatomic, weak) NSObject <RXAPIManagerParams> *child;

/**
 请求参数
 */
@property (nonatomic, strong, readonly) id requestParams;

/**
 回调对象：原始数据对象
 */
@property (nonatomic, strong, readonly) id responseJSONObject;

/**
 自定义的错误回调类型
 */
@property (nonatomic, readonly) RXAPIManagerErrorType errorType;

/**
 api回调的错误信息
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;


/**
 api回调

 @param success 成功
 @param failure 失败
 */
- (void)sendRequestWithCompletionBlockWithSuccess:(RXRequestCompletionBlock)success
                                          failure:(RXRequestCompletionBlock)failure;

/**
 数据组装

 @param reformer 实现<RXApiManagerDataReformer>的对象
 @return 自定义组装好的数据
 */
- (id)fetchDataWithReformer:(id <RXApiManagerDataReformer>)reformer;

/**
 返回需要放到httpHeader的默认参数

 @return data
 */
- (NSDictionary <NSString *,NSString *> *)defaultHttpHeaderParams;

/**
 请求的连接超时时间，默认为30秒

 @return 时间
 */
- (NSTimeInterval)requestTimeoutInterval;

/**
 请求的数据格式，默认为RXRequestSerializerTypeHTTP

 @return 请求的数据格式
 */
- (RXRequestSerializerType)requestSerializerType;


@end
