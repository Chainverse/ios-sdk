//
//  CVSDKUserDefault.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKGameServiceData.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKUserDefault : NSUserDefaults
+ (void) setXUserAddress: (NSString *) value;
+ (NSString *)getXUserAdress;
+ (void)clearXUserAddress;

+ (void) setXUserSignature: (NSString *) value;
+ (NSString *)getXUserSignature;
+ (void)clearXUserSignature;

+ (void) setXUserNonce: (NSString *) value;
+ (NSString *)getXUserNonce;
+ (void)clearXUserNonce;

+ (void) setXUserTime: (NSString *) value;
+ (NSString *)getXUserTime;
+ (void)clearXUserTime;

+ (void) setXUserSignatureV2: (NSString *) value;
+ (NSString *)getXUserSignatureV2;
+ (void)clearXUserSignatureV2;

+ (void) setConnectWallet: (NSString *) value;
+ (NSString *)getConnectWallet;
+ (void)clearConnectWallet;

+ (void) setMnemonic: (NSString *) value;
+ (NSString *)getMnemonic;
+ (void)clearMnemonic;

+ (void) setRPC: (NSString *) value;
+ (NSString *)getRPC;

+ (void) setGameService: (CVSDKGameServiceData *) value;
+ (CVSDKGameServiceData *)getGameService;
@end

NS_ASSUME_NONNULL_END
