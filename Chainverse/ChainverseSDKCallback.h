//
//  ChainverseSDKCallback.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
#import "ChainverseNFT.h"
@protocol ChainverseSDKCallback <NSObject>

@required
- (void)didInitSDKSuccess;
- (void)didError:(int)error;
- (void)didConnectSuccess:(NSString *) address;
- (void)didLogout:(NSString *) address;
- (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
- (void)didGetDetailItem:(ChainverseNFT*)item;
- (void)didSignMessage:(NSString *) signedMessage;
- (void)didGetListItemMarket:(NSArray<ChainverseNFT> *) items;
- (void)didGetMyAssets:(NSArray<ChainverseNFT> *) items;
- (void)didTransact:(int)function tx:(NSString *)tx;
@end


