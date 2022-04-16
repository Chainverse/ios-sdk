//
//  CVSDKRPCRequest.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "CVSDKRPCClient.h"
#import "CVSDKConstant.h"
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

+ (NSMutableArray *)createParams:( nullable NSMutableDictionary *)obj{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    if(obj != nil){
        [params addObject:obj];
    }
    return params;
}

- (NSString *)createRequestRaw:(NSString *)method params:(NSMutableArray*) params{
    NSError *writeError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self createPayload:method params:params] options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString* raw = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"nampv_fuc %@",raw);
    return raw;
}

- (NSMutableURLRequest *) createRequest:(NSString *)raw{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:DEFAULT_RPC] cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:120];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [raw dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

- (NSMutableDictionary *) createPayload:(NSString *)method params:(NSMutableArray*) params{
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
        [params addObject: @"latest"];
       payload[@"jsonrpc"] = @"2.0";
       payload[@"method"] = method;
       payload[@"params"] = params;
       payload[@"id"] = @"1";
    return payload;
}
@end
