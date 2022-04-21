//
//  CVSDKWeb3.h
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//

#import <Foundation/Foundation.h>
#import "Chainverse-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBridgingWeb3 : NSObject
+ (CVSDKBridgingWeb3 *) shared;
- (void)initialize:(NSString *)urlRPC;
- (BOOL)isDeveloperContract:(NSString *)address;
- (BOOL)isGameContract:(NSString *)address;
- (BOOL)isGamePaused:(NSString *)factoryAddress gameAddress:(NSString *)gameAddress;
- (BOOL)isDeveloperPaused:(NSString *)factoryAddress developerAddress:(NSString *)developerAddress;
- (BOOL) isAddress:(NSString *)address;
- (NSString *)getBalance:(NSString *)address;
- (NSString *)getBalance:(NSString *)contractAddress owner:(NSString *)address;
- (NSString *)signMessage:(NSString *)message;
- (NSString *)signPersonalMessage:(NSString *)message;
- (NSString *)signTransaction:(NSString *)nonce gasPrice:(NSString *)gasPrice gasLimit:(NSString *)gasLimit toAddress:(NSString *)toAddress value:(NSString *)value chainID:(NSString *)chainID templateData:(NSData *)templateData;
- (NSString *)sendEth:(NSString *)Mnemonic;
- (NSString *)buyNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)feeBuyNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;

- (NSString *)bidNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)sellNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency;
- (NSString *)feeSellNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency;
- (NSString *)approveToken:(NSString*)walletAddress token:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount;
- (NSString *)feeApproveToken:(NSString*)walletAddress token:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount;
- (NSString *)approveNFT:(NSString *)service abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)feeApproveNFT:(NSString *)service abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)cancelSellNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress listing:(NSInteger )listingId;
- (NSMutableDictionary *)getByNFT:(NSString *)serviceAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)getTokenUri:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner spender:(NSString *)spender;
- (NSString *)transferItem:(NSString *)walletAddress to:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)feeTransferItem:(NSString *)walletAddress to:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)withdrawNFT:(NSString *)walletAddress gameAddress:(NSString *)gameAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveService:(NSString *)walletAddress serviceAddress:(NSString *)serviceAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSInteger)getBlockNumber:(NSString *)rpc;
@end

NS_ASSUME_NONNULL_END
