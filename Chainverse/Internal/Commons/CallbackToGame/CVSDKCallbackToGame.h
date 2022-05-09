//
//  CVSDKCallbackToGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
#import "CVSDKTokenURI.h"
#import "NFT.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKCallbackToGame : NSObject
+ (void)didConnectSuccess:(NSString *)address;
+ (void)didLogout:(NSString *)address;
+ (void)didInitSDKSuccess;
+ (void)didError:(int) error;
+ (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
+ (void)didSignMessage:(NSString *) signedMessage;
+ (void)didGetListItemMarket:(NSMutableArray<NFT> *) items;
+ (void)didGetMyAssets:(NSMutableArray<NFT> *) items;
+ (void)didTransact:(int)function tx:(NSString *)tx;
+ (void)didGetDetailItem:(NFT*)item;
@end

NS_ASSUME_NONNULL_END
