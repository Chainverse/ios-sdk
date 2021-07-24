//
//  CVSDKCallbackToGame.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import "CVSDKCallbackToGame.h"
#import "ChainverseSDK.h"
@implementation CVSDKCallbackToGame
+ (void)didUserAddress:(NSString *)address{
    if(address != nil){
        if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didUserAddress:)]){
            [[ChainverseSDK shared].delegate didUserAddress:address];
        }
    }
}
+ (void)didUserLogout:(NSString *)address{
    if(address != nil){
        if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didUserLogout:)]){
            [[ChainverseSDK shared].delegate didUserLogout:address];
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
@end
