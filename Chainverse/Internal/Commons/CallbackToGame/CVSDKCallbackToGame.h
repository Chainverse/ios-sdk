//
//  CVSDKCallbackToGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
#import "CVSDKTokenURI.h"
#import "ChainverseNFT.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKCallbackToGame : NSObject
+ (void)didConnectSuccess:(NSString *)address;
+ (void)didLogout:(NSString *)address;
+ (void)didInitSDKSuccess;
+ (void)didError:(int) error;
+ (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
+ (void)didSignMessage:(NSString *) signedMessage;
+ (void)didGetListItemMarket:(NSArray<ChainverseNFT> *) items;
+ (void)didGetMyAssets:(NSArray<ChainverseNFT> *) items;
+ (void)didTransact:(int)function tx:(NSString *)tx;
+ (void)didGetDetailItem:(ChainverseNFT*)item;
@end

NS_ASSUME_NONNULL_END
