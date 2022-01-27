//
//  CVSDKBridgingClass.h
//  Chainverse-SDK
//
//  Created by Mac on 7/20/21.
//

#import <Foundation/Foundation.h>
#import "Chainverse_SDK-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBridging : NSObject
+ (NSString *)keccak256:(NSString *)gameAddress;
+ (NSString *)EthFunctionEncode:(NSString *)method address:(NSString *)address;
@end

NS_ASSUME_NONNULL_END
