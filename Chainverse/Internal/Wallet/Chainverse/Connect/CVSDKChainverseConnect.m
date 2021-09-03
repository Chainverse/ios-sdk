//
//  CVSDKChainverseConnect.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import "CVSDKChainverseConnect.h"
#import "CVSDKUtils.h"
#import "ChainverseSDK.h"

@implementation CVSDKChainverseConnect
- (NSURL *)build{
    NSURLComponents *components = [NSURLComponents new];

    [components setScheme:@"chainverse"];
    [components setHost:@"sdk_account_sign_message"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"action" value:@"account_sign_message"],
        [NSURLQueryItem queryItemWithName:@"coins.0" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"coin" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"data" value:@"chainverse"],
        [NSURLQueryItem queryItemWithName:@"app" value:[ChainverseSDK shared].scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"accounts_callback"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"0"]
    ];
    
    NSURL *url = components.URL;
    NSLog(@"chainverse_url %@",url.absoluteString);
    return url;
}

- (void)connect{
    [CVSDKUtils openURL:[self build]];
    
}
@end
