//
//  CVSDKRPCRequest.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "CVSDKRPCClient.h"
@implementation CVSDKRPCClient
+ (CVSDKRPCClient *)shared{
    static CVSDKRPCClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)connect:(NSMutableArray*) params method:(NSString *)method completeBlock:(CVSDKRPCResponeBlock) complete{
    NSString *raw = [self createRequestRaw:method params:params];
    [[self dataTaskWithRequest:[self createRequest:raw] uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        complete(response,responseObject,error);
    }] resume];
    
}

- (NSString *)createRequestRaw:(NSString *)method params:(NSMutableArray*) params{
    NSError *writeError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self createPayload:method params:params] options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString* raw = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return raw;
}

- (NSMutableURLRequest *) createRequest:(NSString *)raw{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.101.144:8545"] cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:120];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [raw dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

- (NSMutableDictionary *) createPayload:(NSString *)method params:(NSMutableArray*) params{
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
       payload[@"jsonrpc"] = @"2.0";
       payload[@"method"] = method;
       payload[@"params"] = params;
       payload[@"id"] = @"1";
    return payload;
}
@end
