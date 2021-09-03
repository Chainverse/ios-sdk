//
//  CVSDKTrustSignMessage.m
//  Chainverse-SDK
//
//  Created by pham nam on 13/07/2021.
//

#import "CVSDKTrustSignMessage.h"
#import "CVSDKUtils.h"
#import "ChainverseSDK.h"
@implementation CVSDKTrustSignMessage
- (NSURL *)build{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"trust"];
    [components setHost:@"sdk_sign_message"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"coin" value:@"60"],
        [NSURLQueryItem queryItemWithName:@"data" value:self.data],
        [NSURLQueryItem queryItemWithName:@"app" value:[ChainverseSDK shared].scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"1"]
    ];
    
    NSURL *url = components.URL;
    NSLog(@"chainverse_url %@",url.absoluteString);
    return url;
}

- (void)signMessage{
    [CVSDKUtils openURL:[self build]];
}
@end
