//
//  CVSDKWeb3.m
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//

#import "CVSDKBridgingWeb3.h"
#import "CVSDKBaseResource.h"
#import "CVSDKABI.h"
#import "CVSDKUserDefault.h"
@interface CVSDKBridgingWeb3(){
   
}
@property (nonatomic, nonatomic) CVWeb3 *web3;
@end
@implementation CVSDKBridgingWeb3
+ (CVSDKBridgingWeb3 *)shared{
    static CVSDKBridgingWeb3 *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init]; 
    });
    return _shared;
}

- (void)initialize:(NSString *)urlRPC{
    self.web3 = [[CVWeb3 alloc] init];
    NSLog(@"CVSDK_Default_RPC %@",urlRPC);
    [self.web3 initWeb3WithEndpoint:urlRPC];
}

- (BOOL) isAddress:(NSString *)address{
    return [self.web3 isAddressWithAddress:address];
}
- (BOOL)isDeveloperContract:(NSString *)address{
    return [self.web3 isDeveloperContractWithAddress:address abi:ABI_Developer];
}
- (BOOL)isGameContract:(NSString *)address{
    return [self.web3 isGameContractWithAddress:address abi:ABI_Game];
}
- (BOOL)isGamePaused:(NSString *)factoryAddress gameAddress:(NSString *)gameAddress{
    return [self.web3 isGamePausedWithContractAddress:factoryAddress abi:ABI_Factory gameAddress:gameAddress];
}
- (BOOL)isDeveloperPaused:(NSString *)factoryAddress developerAddress:(NSString *)developerAddress{
    return [self.web3 isDeveloperPausedWithContractAddress:factoryAddress abi:ABI_Factory gameAddress:developerAddress];
}

- (NSString *)getBalance:(NSString *)address{
    return [self.web3 getBalanceWithAddress:address];
}

- (NSString *)getBalance:(NSString *)contractAddress owner:(NSString *)address{
    return [self.web3 getBalanceTokenWithContractAddress:contractAddress owner:address];
}

- (NSString *)signMessage:(NSString *)message{
    return [NSString stringWithFormat:@"0x%@",[self.web3 signMessageWithMessage:message]];
}

- (NSString *)signPersonalMessage:(NSString *)message{
    return [NSString stringWithFormat:@"0x%@",[self.web3 signPersonalMessageWithMessage:message]];
}

- (NSString *)signTransaction:(NSString *)nonce gasPrice:(NSString *)gasPrice gasLimit:(NSString *)gasLimit toAddress:(NSString *)toAddress value:(NSString *)value chainID:(NSString *)chainID templateData:(NSData *)templateData{
    return [self.web3 signTransactionWithNonce:nonce gasPrice:gasPrice gasLimit:gasLimit toAddress:toAddress value:value chainID:chainID templateData:templateData];
}

- (NSString *)sendEth:(NSString *)Mnemonic{
    //[self.web3 sendEthWith_mnemonics:Mnemonic];
    return @"";
}

- (NSString *)buyNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [self.web3 buyNFTWithMarketService:marketService abi:abi walletAddress:walletAddress currency:currency listingId:listingId price:[NSString stringWithFormat:@"%@",price]];
}

- (NSString *)feeBuyNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [self.web3 feeBuyNFTWithMarketService:marketService abi:abi walletAddress:walletAddress currency:currency listingId:listingId price:[NSString stringWithFormat:@"%@",price]];
}

- (NSString *)bidNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress currency:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [self.web3 bidNFTWithMarketService:marketService abi:abi walletAddress:walletAddress currency:currency listingId:listingId price:price];
}

- (NSString *)sellNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    return [self.web3 sellNFTWithMarketService:marketService abi:abi walletAddress:walletAddress nft:nft tokenId:tokenId price:price currency:currency];
}
- (NSString *)approveToken:(NSString*)walletAddress token:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount{
    return [self.web3 approveTokenWithWalletAddress:walletAddress token:token spender:spender value:amount];
}

- (NSString *)approveNFT:(NSString *)service abi:(NSString *)abi walletAddress:(NSString*)walletAddress nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [self.web3 approveNFTWithService:service abi:abi walletAddress:walletAddress nft:nft tokenId:tokenId];
}

- (NSString *)cancelSellNFT:(NSString *)marketService abi:(NSString *)abi walletAddress:(NSString*)walletAddress listing:(NSInteger )listingId{
    return [self.web3 cancelSellNFTWithMarketService:marketService abi:abi walletAddress:walletAddress listingId:listingId];
}

- (NSMutableDictionary *)getByNFT:(NSString *)serviceAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSMutableDictionary *result = [self.web3 getByNFTWithMarketService:serviceAddress abi:abi nft:nft tokenId:tokenId];
    return result;
}
- (NSString *)getTokenUri:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tokenUri = [self.web3 getTokenUriWithNft:nft tokenId:tokenId];
    return tokenUri;
}

- (NSString *)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [self.web3 isApprovedWithNft:nft tokenId:tokenId];
}

- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner spender:(NSString *)spender{
    return [self.web3 isApprovedWithToken:token owner:owner spender:spender];
}

- (NSString *)transferItem:(NSString *)walletAddress to:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [self.web3 transferItemWithWalletAddress:walletAddress to:to nft:nft tokenId:tokenId];
}

- (NSString *)withdrawNFT:(NSString *)walletAddress gameAddress:(NSString *)gameAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [self.web3 withdrawNFTWithWalletAddress:walletAddress gameAddress:gameAddress abi:abi nft:nft tokenId:tokenId];
}

- (NSString *)moveService:(NSString *)walletAddress serviceAddress:(NSString *)serviceAddress abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [self.web3 moveServiceWithWalletAddress:walletAddress serviceAddress:serviceAddress abi:abi nft:nft tokenId:tokenId];
}

- (NSInteger)getBlockNumber:(NSString *)rpc{
    return [self.web3 getBlockNumberWithRpc:rpc];
}
@end
