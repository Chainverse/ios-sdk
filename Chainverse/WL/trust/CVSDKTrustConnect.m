//
//  TrustWLConnect.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "CVSDKTrustConnect.h"
#import "UIKit/UIKit.h"
@implementation CVSDKTrustConnect

- (NSURL *)build{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"trust"];
    [components setHost:@"sdk_get_accounts"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"coins.0" value:@"60"],
        [NSURLQueryItem queryItemWithName:@"coins.1" value:@"714"],
        [NSURLQueryItem queryItemWithName:@"app" value:self.scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"1"]
    ];
    NSURL *url = components.URL;
    NSLog(@"chainverse_url %@",url.absoluteString);
    return url;
}

- (void)connect{
    if ([[UIApplication sharedApplication] canOpenURL:[self build]]) {
        [[UIApplication sharedApplication] openURL:[self build] options:@{} completionHandler:nil];
    }
    
}
@end
