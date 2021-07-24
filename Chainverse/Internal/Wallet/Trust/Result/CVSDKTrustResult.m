//
//  CVSDKTrustResult.m
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import "CVSDKTrustResult.h"
#import "CVSDKUtils.h"
#import "CVSDKDefine.h"
@implementation CVSDKTrustResult
+ (NSString *)getUserAddress:(NSURL *)url{
    NSString *address = nil;
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"] isEqualToString:@""]){
        NSString *accounts = [CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"];
        address = [[accounts componentsSeparatedByString:@","] objectAtIndex:0];
        
    }
    return address;
}

+ (int)getAction:(NSURL *) url{
    int action = 0;
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"] isEqualToString:@""]){
        action = TrustAccount;
    }
    
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"signature"] isEqualToString:@""]){
        action = TrustSignature;
    }
    
    return action;
}

+ (NSString *)getSignature: (NSURL *)url{
    return [CVSDKUtils getValueFromQueryParam:url withParam:@"signature"];
}
@end
