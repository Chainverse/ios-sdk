//
//  ChainverseSDKCallback.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
#import "NFT.h"
@protocol ChainverseSDKCallback <NSObject>

@required
- (void)didInitSDKSuccess;
- (void)didError:(int)error;
- (void)didConnectSuccess:(NSString *) address;
- (void)didLogout:(NSString *) address;
- (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
- (void)didGetDetailItem:(NFT*)item;
- (void)didSignMessage:(NSString *) signedMessage;
- (void)didGetListItemMarket:(NSMutableArray<NFT> *) items;
- (void)didGetMyAssets:(NSMutableArray<NFT> *) items;
- (void)didTransact:(int)function tx:(NSString *)tx;
@end


