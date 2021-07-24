//
//  CVSDKRESTfulClient.m
//  Chainverse-SDK
//
//  Created by pham nam on 25/06/2021.
//

#import "CVSDKRESTfulClient.h"

@implementation CVSDKRESTfulClient
+ (CVSDKRESTfulClient *)shared{
    static CVSDKRESTfulClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[CVSDKRESTfulClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return _shared;
}

- (void)get:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure{
    [self GET:@"" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)post:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure{
    [self POST:@"" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
@end
