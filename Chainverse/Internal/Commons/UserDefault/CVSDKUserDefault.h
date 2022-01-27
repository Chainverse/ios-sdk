//
//  CVSDKUserDefault.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKUserDefault : NSUserDefaults
+ (void) setXUserAddress: (NSString *) value;
+ (NSString *)getXUserAdress;
+ (void)clearXUserAddress;

+ (void) setXUserSignature: (NSString *) value;
+ (NSString *)getXUserSignature;
+ (void)clearXUserSignature;

+ (void) setConnectWallet: (NSString *) value;
+ (NSString *)getConnectWallet;
+ (void)clearConnectWallet;

+ (void) setMnemonic: (NSString *) value;
+ (NSString *)getMnemonic;
+ (void)clearMnemonic;

@end

NS_ASSUME_NONNULL_END
