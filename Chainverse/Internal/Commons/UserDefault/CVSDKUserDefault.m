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
@implementation CVSDKUserDefault
+ (void) setXUserAddress: (NSString *) value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:KEY_1];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getXUserAdress{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_1];
    //return @"0x11A75F1D4A191Eea9a6670ce05bD8F4b2C226333";
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
    //return @"8eb65401ed1d6296783883bdff92247b84c32c09a05ecb7fa2be19d3d27a663a2db56054682d4c387749f941c6758c5d64c889c082523866d701845d1b8dda831c";
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
@end
