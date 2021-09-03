//
//  CVSDKRESTfulClient.m
//  Chainverse-SDK
//
//  Created by pham nam on 25/06/2021.
//

#import "CVSDKRESTfulClient.h"
#import "CVSDKUserDefault.h"
#import "ChainverseSDK.h"
#import "CVSDKConstant.h"
#import "CVSDKUserDefault.h"
@implementation CVSDKRESTfulClient
+ (CVSDKRESTfulClient *)shared{
    static CVSDKRESTfulClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[CVSDKRESTfulClient alloc] initWithBaseURL:[NSURL URLWithString:urlRestful]];
    });
    return _shared;
}

- (void)get:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure{
    
    [self.requestSerializer setValue:[CVSDKUserDefault getXUserSignature] forHTTPHeaderField:@"X-User-Signature"];
    [self.requestSerializer setValue:@"true" forHTTPHeaderField:@"X-Signature-Ethers"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self GET:action parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

//Test
- (void)connect:(NSMutableArray*) params method:(NSString *)method completeBlock:(CVSDKRPCResponeBlock) complete{
    NSString *raw = [self createRequestRaw:method params:params];
    [[self dataTaskWithRequest:[self createRequest:raw] uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        complete(response,responseObject,error);
    }] resume];
    
}

- (NSMutableURLRequest *) createRequest:(NSString *)raw{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlBuyTest] cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:120];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [raw dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

- (NSString *)createRequestRaw:(NSString *)method params:(NSMutableArray*) params{
    NSError *writeError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self createPayload:method params:params] options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString* raw = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"nampv_fuc %@",raw);
    return raw;
}

- (NSMutableDictionary *) createPayload:(NSString *)method params:(NSMutableArray*) params{
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
        //[params addObject: @"latest"];
       payload[@"game_contract"] = [ChainverseSDK shared].gameAddress;
       payload[@"player_address"] = [CVSDKUserDefault getXUserAdress];
       payload[@"category_id"] = @"1";
       payload[@"type"] = @"2";
    return payload;
}

@end
