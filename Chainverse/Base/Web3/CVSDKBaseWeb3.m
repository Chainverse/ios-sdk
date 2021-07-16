//
//  CVSDKBaseWeb3.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/07/2021.
//

#import "CVSDKBaseWeb3.h"

@implementation CVSDKBaseWeb3
- (void)initWeb3{
    NSURL *url = [[NSURL alloc] initWithString:@"https://data-seed-prebsc-1-s1.binance.org:8545"];
    W3Web3 *web3 = [[W3Web3 alloc] initWithUrl:url];
    assert(web3);
    [W3Web3 setDefault:web3];
}

- (W3Address *) contract : (NSString *)address{
    //[self initWeb3];
    W3Address *contract = [[W3Address alloc] initWithString:address];
    return contract;
}


@end
