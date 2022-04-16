//
//  CVSDKChainverseConnect.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import "CVSDKChainverseApp.h"
#import "CVSDKUtils.h"
#import "ChainverseSDK.h"

@implementation CVSDKChainverseApp
+ (void)connect{
    //chainverse://sdk_account_sign_message?action=account_sign_message&coin=20000714&app=trust-rn-example1://&callback=sdk_account_sign_result&id=2&type=personal&data.0=&data.1=ChainVerse
    NSURLComponents *components = [NSURLComponents new];

    [components setScheme:@"chainverse"];
    [components setHost:@"sdk_account_sign_message"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"action" value:@"account_sign_message"],
        [NSURLQueryItem queryItemWithName:@"coin" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"app" value:[ChainverseSDK shared].scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_account_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"2"],
        [NSURLQueryItem queryItemWithName:@"type" value:@"personal"],
        [NSURLQueryItem queryItemWithName:@"data.0" value:@""],
        [NSURLQueryItem queryItemWithName:@"data.1" value:@"ChainVerse"]
    ];
    
    NSURL *url = components.URL;
    
    [CVSDKUtils openURL:url];
    
}

+ (void)signMessage:(NSString *)message{
    NSURLComponents *components = [NSURLComponents new];

    [components setScheme:@"chainverse"];
    [components setHost:@"sdk_sign_message"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"action" value:@"sdk_sign_message"],
        [NSURLQueryItem queryItemWithName:@"coin" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"app" value:[ChainverseSDK shared].scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"sdk_sign_result"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"1"],
        [NSURLQueryItem queryItemWithName:@"type" value:@"personal"],
        [NSURLQueryItem queryItemWithName:@"data" value:message]
    ];
    
    NSURL *url = components.URL;
    
    [CVSDKUtils openURL:url];
}

+ (void)sendTransaction:(NSString *)action to:(NSString *)to data:(NSString *)data value:(NSString *)value gasLimit:(NSString *)gasLimit gasPrice:(NSString *)gasPrice nonce:(NSString *)nonce{
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"chainverse"];
    [components setHost:@"sdk_transaction"];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"action" value:action],
        [NSURLQueryItem queryItemWithName:@"asset" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"to" value:to],
        [NSURLQueryItem queryItemWithName:@"from" value:@"20000714"],
        [NSURLQueryItem queryItemWithName:@"data" value:data],
        [NSURLQueryItem queryItemWithName:@"amount" value:value],
        [NSURLQueryItem queryItemWithName:@"nonce" value:nonce],
        [NSURLQueryItem queryItemWithName:@"fee_price" value:gasPrice],
        [NSURLQueryItem queryItemWithName:@"fee_limit" value:gasLimit],
        [NSURLQueryItem queryItemWithName:@"app" value:[ChainverseSDK shared].scheme],
        [NSURLQueryItem queryItemWithName:@"callback" value:@"tx_callback"],
        [NSURLQueryItem queryItemWithName:@"confirm_type" value:@"send"],
        [NSURLQueryItem queryItemWithName:@"id" value:@"2"],
        [NSURLQueryItem queryItemWithName:@"meta" value:@"memo"],
    ];
    
    NSURL *url = components.URL;
    
    [CVSDKUtils openURL:url];
}
@end
