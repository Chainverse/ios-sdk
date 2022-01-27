//
//  CVSDKWeb3.m
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//

#import "CVSDKWeb3.h"
#import "CVSDKBaseResource.h"
#import "CVSDKABI.h"
#import "CVSDKUserDefault.h"
@implementation CVSDKWeb3
/*+ (CVSDKWeb3 *)shared{
    static CVSDKWeb3 *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init]; 
    });
    return _shared;
}*/

/*- (void)initialize{
    CVWeb3 *web3 = [[CVWeb3 alloc] init];
    //[web3 initWeb3WithEndpoint:@"https://data-seed-prebsc-1-s1.binance.org:8545"];
    //NSString *result = [web3 callFunctionWithContractAddress:@"0x640Dce1028b1111421b72b884320D0e93d974fB3" contractABI:chainverseFactoryABI];
    [web3 callFunctionWith_mnemonics:[CVSDKUserDefault getMnemonic] contractAddress:@"0x640Dce1028b1111421b72b884320D0e93d974fB3" contractABI:chainverseFactoryABI];
    //NSLog(@"nampv_huc %@",result);
}*/

+ (NSString *)signMessage:(NSString *)message{
    CVWeb3 *web3 = [[CVWeb3 alloc] init];
    NSString *singed = [web3 signMessageWith_mnemonics:[CVSDKUserDefault getMnemonic]];
    return singed;
}
@end
