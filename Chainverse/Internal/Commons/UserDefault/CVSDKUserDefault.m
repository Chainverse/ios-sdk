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

+ (void)setXUserSignature: (NSString *) value{
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
    //return @"mention nut alone feel party notable magnet lonely inspire custom lawsuit include";
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_4];
}

+ (void)clearMnemonic{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_4];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
