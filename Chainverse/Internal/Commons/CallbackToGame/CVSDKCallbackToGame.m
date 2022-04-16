//
//  CVSDKCallbackToGame.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import "CVSDKCallbackToGame.h"
#import "ChainverseSDK.h"
@implementation CVSDKCallbackToGame
+ (void)didConnectSuccess:(NSString *)address{
    if(address != nil){
        if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didConnectSuccess:)]){
            [[ChainverseSDK shared].delegate didConnectSuccess:address];
        }
    }
}
+ (void)didLogout:(NSString *)address{
    if(address != nil){
        if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didLogout:)]){
            [[ChainverseSDK shared].delegate didLogout:address];
        }
    }
}
+ (void)didInitSDKSuccess{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didInitSDKSuccess)]){
        [[ChainverseSDK shared].delegate didInitSDKSuccess];
    }
}

+ (void)didError:(int) error{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didError:)]){
        [[ChainverseSDK shared].delegate didError:error];
    }
}


+ (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    [[ChainverseSDK shared].delegate didItemUpdate:item type:type];
}

+ (void)didSignMessage:(NSString *) signedMessage{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didSignMessage:)]){
        [[ChainverseSDK shared].delegate didSignMessage:signedMessage];
    }
}

+ (void)didGetListItemMarket:(NSArray<ChainverseNFT> *) items{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didGetListItemMarket:)]){
        [[ChainverseSDK shared].delegate didGetListItemMarket:items];
    }
}

+ (void)didGetMyAssets:(NSArray<ChainverseNFT> *) items{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didGetMyAssets:)]){
        [[ChainverseSDK shared].delegate didGetMyAssets:items];
    }
}

+ (void)didTransact:(int)function tx:(NSString *)tx{
    [[ChainverseSDK shared].delegate didTransact:function tx:tx];
}
+ (void)didGetDetailItem:(ChainverseNFT*)item{
    [[ChainverseSDK shared].delegate didGetDetailItem:item];
}

@end
