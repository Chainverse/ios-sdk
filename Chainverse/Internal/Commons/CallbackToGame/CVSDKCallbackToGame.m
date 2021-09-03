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

+ (void)didGetItems:(NSMutableArray *)items{
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didGetItems:)]){
        [[ChainverseSDK shared].delegate didGetItems:items];
    }
}

+ (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    [[ChainverseSDK shared].delegate didItemUpdate:item type:type];
}
@end
