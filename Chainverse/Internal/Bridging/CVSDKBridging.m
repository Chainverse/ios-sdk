//
//  CVSDKBridgingClass.m
//  Chainverse-SDK
//
//  Created by Mac on 7/20/21.
//

#import "CVSDKBridging.h"
@implementation CVSDKBridging
+ (NSString *)keccak256:(NSString *)gameAddress{
    CVSDKHash *hash = [[CVSDKHash alloc] init];
    return [hash keccak256:gameAddress];
}

+ (NSString *)EthFunctionEncode:(NSString *)method params:(NSArray *)params{
    CVSDKSolidityFunction *function = [[CVSDKSolidityFunction alloc] init];
    return [function encode:method :params];
}
@end
