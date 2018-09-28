//
//  RXNetwork.m
//  Copyright © 2015年 Xuan. All rights reserved.
//

#import "RXNetwork.h"

#import <AFNetworking/AFNetworking.h>
#import "RXBaseRequest.h"
#import "RXRequestConfig.h"
#import "RXNetworkLog.h"

@interface RXNetwork ()

/// AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation RXNetwork

#pragma mark - lifeCycle                    - Method -

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSMutableDictionary *)dispatchTable
{
    if (!_dispatchTable) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

- (void)setupResponseSerializerContentTypeForManager:(id)manager
{
    if (manager && [manager respondsToSelector:@selector(responseSerializer)]) {
        id serializer = [manager performSelector:@selector(responseSerializer) withObject:nil];
        if (serializer) {
            AFHTTPResponseSerializer *ser = (AFHTTPResponseSerializer *)serializer;
            ser.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setupResponseSerializerContentTypeForManager:self.sessionManager];
    }
    return self;
}

#pragma mark - request                    - Method -

- (void)sendRequest:(RXBaseRequest *)request success:(RXCallback)success fail:(RXCallback)fail;
{
    NSLog(@"sendRequest: %@", NSStringFromClass([request class]));
    
    NSURLRequest *urlRequest = [[RXRequestConfig sharedInstance] requestWithRXRequest:request];
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if (error) {
            
            [RXNetworkLog logDebugInfoWithResponse:httpResponse
                                responseString:responseString
                                       request:urlRequest
                                         error:error];
            RXURLResponse *resp = [[RXURLResponse alloc] initWithResponseString:responseString requestId:requestID request:urlRequest responseData:responseData error:error];
            
            fail ? fail(resp) : nil;
            
        } else {
            
            [RXNetworkLog logDebugInfoWithResponse:httpResponse
                                responseString:responseString
                                       request:urlRequest
                                         error:NULL];
            
            RXURLResponse *resp = [[RXURLResponse alloc] initWithResponseString:responseString requestId:requestID request:urlRequest responseData:responseData status:CTURLResponseStatusSuccess];
            
            success ? success(resp) : nil;
        }
        
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    request.dataTask = dataTask;
    [dataTask resume];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}


@end
