//
//  CVSDKChainverseResult.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import "CVSDKChainverseAppResult.h"
#import "CVSDKUtils.h"
@implementation CVSDKChainverseAppResult
+ (NSString *)getUserAddress:(NSURL *)url{
    NSString *address = nil;
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"] isEqualToString:@""]){
        NSString *accounts = [CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"];
        address = [[accounts componentsSeparatedByString:@","] objectAtIndex:0];
        
    }
    return address;
}


+ (NSString *)getSignature0: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"signature.0"];
}

+ (NSString *)getSignature1: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"signature.1"];
}

+ (NSString *)getSignature: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"signature"];
}

+ (NSString *)getTime: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"time"];
}
+ (NSString *)getNonce: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"nonce"];
}

+ (NSString *)getAction: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"action"];
}

+ (NSString *)getData: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"data"];
}
@end
