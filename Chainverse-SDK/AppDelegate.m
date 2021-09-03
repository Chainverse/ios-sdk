//
//  AppDelegate.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "AppDelegate.h"
#import "ChainverseSDK.h"
#import "ChainverseSDKCallback.h"
#import "ChainverseSDKError.h"
#import "ChainverseItem.h"
@interface AppDelegate ()<ChainverseSDKCallback>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ChainverseSDK shared].developerAddress = @"0xE1717d89f2d7A7b4834c2724408b319ABAf500ec";
    [ChainverseSDK shared].gameAddress = @"0xD146b45817fd18555c59c061C840e3a446Cd5A6c";
    [ChainverseSDK shared].scheme = @"trust-rn-example://";
    [ChainverseSDK shared].delegate = self;
    [[ChainverseSDK shared] initialize];
    [[ChainverseSDK shared] setKeepConnect:TRUE];
    
    NSLog(@"ChainverSDK Verison %@",[[ChainverseSDK shared] getVersion]);
    
    return YES;
}

- (void)didInitSDKSuccess{
    
}

- (void)didConnectSuccess:(NSString *)address{
    NSLog(@"ChainverseSDKCallback_didConnectWallet %@",address);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:address forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"SampleNotiAddress" object:nil userInfo:userInfo];
    [[ChainverseSDK shared] getItems];
    
    ChainverseUser *info = [[ChainverseSDK shared] getUser];
    NSLog(@"nampv_caddress %@",[info address]);
    NSLog(@"nampv_csign %@",[info signature]);
}

- (void)didLogout:(NSString *)address{
    NSLog(@"didLogout");
}

- (void)didError:(int)error{
    switch (error) {
        case ERROR_WAITING_INIT_SDK:
            
            break;
            
        default:
            break;
    }
    NSLog(@"didError %d",error);
}

- (void)didGetItems:(NSMutableArray *)items{
    NSLog(@"didGetItems %@",items);
    for(ChainverseItem *itemx in items){
        NSLog(@"nampv_fic1 %@",itemx.game_address);
    }
}

- (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    switch (type) {
        case TRANSFER_ITEM_TO_USER:
            //Xử lý item trong game khi item NFT chuyển tới tài khoản của bạn
            NSLog(@"nampv_transfer_to %@",item);
            break;
        case TRANSFER_ITEM_FROM_USER:
            //Xử lý item trong game khi item NFT của bạn chuyến tời tài khoản khác
            NSLog(@"nampv_transfer_from %@",item);
            break;
    }
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
