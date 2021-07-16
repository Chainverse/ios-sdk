//
//  AppDelegate.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "AppDelegate.h"
#import "ChainverseSDK.h"
#import "ChainverseSDKCallback.h"
@interface AppDelegate ()<ChainverseSDKCallback>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ChainverseSDK shared].developerAddress = @"0x690FDdc2a98050f924Bd7Ec5900f2D2F49b6aEC7";
    [ChainverseSDK shared].gameAddress = @"0x3F57BF31E55de54306543863E079aD234f477b88";
    [ChainverseSDK shared].scheme = @"trustsdk";
    [ChainverseSDK shared].delegate = self;
    [[ChainverseSDK shared] start];
    
    NSLog(@"ChainverSDK Verison %@",[[ChainverseSDK shared] getVersion]);
    
    return YES;
}

- (void)didConnectWallet:(NSString *)address{
    NSLog(@"ChainverseSDKCallback_didConnectWallet %@",address);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:address forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"SampleNotiAddress" object:nil userInfo:userInfo];
}

- (void)didSocketCallback:(NSArray *)data{
    NSLog(@"nampv_socket_callback");
}


- (BOOL)application:(UIApplication *)app
                    openURL:(NSURL *)url
                    options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [[ChainverseSDK shared] handleOpenUrl:(UIApplication *)app
                              openURL:(NSURL *)url
                              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options];
    return true;
}


@end
