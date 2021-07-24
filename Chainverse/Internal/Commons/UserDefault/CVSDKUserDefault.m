//
//  CVSDKUserDefault.m
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import "CVSDKUserDefault.h"
NSString *const KEY_1 = @"chainverse_x_user_address";
NSString *const KEY_2 = @"chainverse_x_user_signature";
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
@end
