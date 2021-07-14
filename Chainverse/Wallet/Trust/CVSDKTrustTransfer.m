//
//  TrustWLTransfer.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "CVSDKTrustTransfer.h"
#import "CVSDKUtils.h"
@implementation CVSDKTrustTransfer

- (NSURL *)build{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"trust"];
    [components setHost:@"sdk_transaction"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"action" value:@"transfer"],
        [NSURLQueryItem queryItemWithName:@"amount" value:self.amount],
        [NSURLQueryItem queryItemWithName:@"asset" value:self.asset],
        [NSURLQueryItem queryItemWithName:@"confirm_type" value:@"sign"],
        [NSURLQueryItem queryItemWithName:@"fee_limit" value:self.feeLimit],
        [NSURLQueryItem queryItemWithName:@"fee_price" value:self.feePrice],
        [NSURLQueryItem queryItemWithName:@"nonce" value:@"447"],
        [NSURLQueryItem queryItemWithName:@"to" value:self.to],
        [NSURLQueryItem queryItemWithName:@"app" value:self.scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"3"],
    ];
    NSURL *url = components.URL;
    NSLog(@"chainverse_url %@",url.absoluteString);
    return url;
}
- (void)transfer{
    [CVSDKUtils openURL:[self build]];
}
@end
