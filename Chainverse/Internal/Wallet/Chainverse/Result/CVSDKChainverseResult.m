//
//  CVSDKChainverseResult.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import "CVSDKChainverseResult.h"
#import "CVSDKUtils.h"
@implementation CVSDKChainverseResult
+ (NSString *)getUserAddress:(NSURL *)url{
    NSString *address = nil;
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"] isEqualToString:@""]){
        NSString *accounts = [CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"];
        address = [[accounts componentsSeparatedByString:@","] objectAtIndex:0];
        
    }
    return address;
}


+ (NSString *)getSignature: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"signature"];
}
@end
