//
//  CVSDKWallet.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import <Foundation/Foundation.h>
#import "Chainverse_SDK-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWallet : NSObject
+ (NSString *)createMnemonics:(NSInteger *)length;
+ (NSString *)importWallet:(NSString *)mnemonics;
+ (NSString *)getPrivateKey;
+ (NSString *)signMessage:(NSString *)message;
+ (NSString *)signFuck:(NSString *)mnemonics;
@end

NS_ASSUME_NONNULL_END
