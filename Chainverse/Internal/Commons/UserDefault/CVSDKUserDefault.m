//
//  CVSDKUserDefault.m
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import "CVSDKUserDefault.h"
NSString *const KEY_1 = @"CHAINVERSE_SDK_KEY_1";
NSString *const KEY_2 = @"CHAINVERSE_SDK_KEY_2";
NSString *const KEY_3 = @"CHAINVERSE_SDK_KEY_3";
NSString *const KEY_4 = @"CHAINVERSE_SDK_KEY_4";
NSString *const KEY_5 = @"CHAINVERSE_SDK_KEY_5";
NSString *const KEY_6 = @"CHAINVERSE_SDK_KEY_6";
NSString *const KEY_7 = @"CHAINVERSE_SDK_KEY_7";
NSString *const KEY_8 = @"CHAINVERSE_SDK_KEY_8";
NSString *const KEY_9 = @"CHAINVERSE_SDK_KEY_9";
@implementation CVSDKUserDefault
+ (void) setXUserAddress: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_1];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getXUserAdress{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_1];
}

+ (void)clearXUserAddress{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_1];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setXUserSignature: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getXUserSignature{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_2];
}

+ (void)clearXUserSignature{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_2];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void) setConnectWallet: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_3];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getConnectWallet{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_3];
}

+ (void)clearConnectWallet{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_3];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setMnemonic: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_4];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getMnemonic{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_4];
}

+ (void)clearMnemonic{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_4];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setXUserNonce: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_5];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getXUserNonce{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_5];
}
+ (void)clearXUserNonce{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_5];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setXUserTime: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_6];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getXUserTime{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_6];
}
+ (void)clearXUserTime{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_6];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setXUserSignatureV2: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_7];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getXUserSignatureV2{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_7];
}
+ (void)clearXUserSignatureV2{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_7];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void) setRPC: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_8];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getRPC{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_8];
}

/*+ (void) setGameService: (CVSDKGameServiceData *) value{
    //[[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_9];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:KEY_9];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CVSDKGameServiceData *)getGameService{
    //CVSDKGameServiceData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_9];
    //return data;
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_9];
    CVSDKGameServiceData *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
    
}*/
@end
