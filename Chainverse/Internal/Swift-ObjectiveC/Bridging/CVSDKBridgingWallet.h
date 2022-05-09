//
//  CVSDKWallet.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import <Foundation/Foundation.h>
#import "Chainverse_SDK-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBridgingWallet : NSObject
+ (CVSDKBridgingWallet *) shared;
- (void)initialize;
- (NSString *)genMnemonic:(NSInteger *)length;
- (NSString *)getMnemonic;
- (NSString *)importWallet:(NSString *)mnemonics;
- (NSString *)getPrivateKey;
@end

NS_ASSUME_NONNULL_END
