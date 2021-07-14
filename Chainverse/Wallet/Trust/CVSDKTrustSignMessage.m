//
//  CVSDKTrustSignMessage.m
//  Chainverse-SDK
//
//  Created by pham nam on 13/07/2021.
//

#import "CVSDKTrustSignMessage.h"
#import "CVSDKUtils.h"
@implementation CVSDKTrustSignMessage
- (NSURL *)build{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"trust"];
    [components setHost:@"sdk_sign_message"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"coin" value:@"60"],
        [NSURLQueryItem queryItemWithName:@"data" value:@"b0379d0047424de9fa43620fd073532a0135cf4a85e8d7bc9ca8aae9bcd8cc4c"],
        [NSURLQueryItem queryItemWithName:@"app" value:@"trustsdk"],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"1"]
    ];
    NSURL *url = components.URL;
    NSLog(@"chainverse_url %@",url.absoluteString);
    return url;
}

- (void)signMessage:(NSString *)message{
    [CVSDKUtils openURL:[self build]];
}
@end
