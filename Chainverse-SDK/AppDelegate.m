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
#import "NFT.h"
@interface AppDelegate ()<ChainverseSDKCallback>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ChainverseSDK shared].developerAddress = @"0x6A6c53a166DDDbE7049982864d21C75AB18fc50C";
    [ChainverseSDK shared].gameAddress = @"0x13f1A9097A7Cd7BeBC5Ad5c79160db3067FEf20E";
    [ChainverseSDK shared].scheme = @"flappy-bird-nft://";
    [ChainverseSDK shared].delegate = self;
    [[ChainverseSDK shared] initialize];
    [[ChainverseSDK shared] setKeepConnect:TRUE];
    
    NSLog(@"ChainverSDK Verison %@",[[ChainverseSDK shared] getVersion]);
    
    return YES;
}

- (void)didInitSDKSuccess{
    NSMutableArray<Currency> *currencies = [[ChainverseSDK shared] getListCurrencies];
    NSLog(@"nampv_listcurrencies %@",currencies);
}

- (void)didConnectSuccess:(NSString *)address{
    NSLog(@"ChainverseSDKCallback_didConnectWallet %@",address);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:address forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"didConnectSuccess" object:nil userInfo:userInfo];
    
    ChainverseUser *info = [[ChainverseSDK shared] getUser];
    
    NSLog(@"nampv_caddress %@",[info toJSONString]);
    NSLog(@"nampv_csign %@",[info signature]);
}

- (void)didLogout:(NSString *)address{
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:address forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"didLogout" object:nil userInfo:userInfo];
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


- (void)didGetDetailItem:(NFT*)item{
    [item toJSONString];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:item forKey:@"GetDetailNFT"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"didGetDetailItem" object:nil userInfo:userInfo];
}

- (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    NSLog(@"nampv_diditemupdate %@",[item toJSONString]);
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

- (void)didSignMessage:(NSString *)signedMessage{
    NSLog(@"ChainverseSDKCallback_didSignMessage %@",signedMessage);
}

- (void)didGetListItemMarket:(NSMutableArray<NFT> *) items{
    //NSArray *myModels;
    //NSLog(@"nampv_didGetListItemMarket %@",items);
    NSArray *dictionaries = [NFT arrayOfDictionariesFromModels:items];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionaries options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"nampv_tojson1 %@",string);
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:items forKey:@"marketItems"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"SampleMarketItem" object:nil userInfo:userInfo];
}

- (void)didGetMyAssets:(NSMutableArray<NFT> *) items{
    
    NSArray *dictionaries = [NFT arrayOfDictionariesFromModels:items];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionaries options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"nampv_tojson %@",string);
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:items forKey:@"myAssetItems"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"SampleMyAssetItem" object:nil userInfo:userInfo];
}

- (void)didTransact:(int)function tx:(NSString *)tx{
    NSLog(@"nampv_didTransact %@",tx);
    NSNumber *func = [NSNumber numberWithInt:function];
    NSDictionary *tmp = @{
        @"function" : func,
        @"tx":tx
    };
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:tmp forKey:@"didTransact"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
                           @"didTransact" object:nil userInfo:userInfo];
    
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
