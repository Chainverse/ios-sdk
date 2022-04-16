//
//  ContractManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKContractManager : NSObject
+ (CVSDKContractManager *) shared;
- (void)checkInitSDK:(CVSDKContractStatusBlock) complete;
- (NSString *)buyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)feeBuyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;

- (NSString *)bidNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)approveToken:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount;
- (NSString *)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency;
- (NSString *)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)approveNFTForGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)approveNFTForService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)cancelSellNFT: (NSInteger )listingId;
- (void)getNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKGetNFTBlock) complete;
- (NSString *)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner spender:(NSString *)spender;
- (NSString *)transferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
@end

NS_ASSUME_NONNULL_END
