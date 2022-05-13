//
//  ContractManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "CVSDKContractManager.h"
#import "CVSDKRPCClient.h"
#import "CVSDKUtils.h"
#import <PromiseKit/PromiseKit.h>
#import "CVSDKConstant.h"
#import "CVSDKConvert.h"
#import "CVSDKCallbackToGame.h"
#import "ChainverseSDKError.h"
#import "ChainverseSDK.h"

#import "CVSDKBridgingWeb3.h"
#import "CVSDKABI.h"
#import "CVSDKUserDefault.h"
#import "CVSDKRESTfulClient.h"
#import "CVSDKParseJson.h"
#import "NFT.h"
#import "Auction.h"
@implementation CVSDKContractManager
+ (CVSDKContractManager *)shared{
    static CVSDKContractManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)checkInitSDK:(CVSDKContractStatusBlock) complete{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.chainverse.contract", NULL);
    dispatch_async(backgroundQueue, ^{
        if([self isGameContract]
           && [self isDeveloperContract]
           && ![self isGamePaused]
           && ![self isDeveloperPaused]){
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(TRUE);
            
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(FALSE);
            });
        }
        
        [self callBackError];
    });
}

- (void)callBackError{
    if(![self isGameContract]){
        [CVSDKCallbackToGame didError:ERROR_GAME_ADDRESS];
    }
    
    if(![self isDeveloperContract]){
        [CVSDKCallbackToGame didError:ERROR_DEVELOPER_ADDRESS];
    }
    
    if([self isGamePaused]){
        [CVSDKCallbackToGame didError:ERROR_GAME_PAUSE];
    }
    
    if([self isDeveloperPaused]){
        [CVSDKCallbackToGame didError:ERROR_DEVELOPER_PAUSE];
    }
}

- (BOOL)isDeveloperContract{
    return [[CVSDKBridgingWeb3 shared] isDeveloperContract:[ChainverseSDK shared].developerAddress];
}
- (BOOL)isGameContract{
    return [[CVSDKBridgingWeb3 shared] isGameContract:[ChainverseSDK shared].gameAddress];
}
- (BOOL)isGamePaused{
    return [[CVSDKBridgingWeb3 shared] isGamePaused:chainverseFactoryAddress gameAddress:[ChainverseSDK shared].gameAddress];
}
- (BOOL)isDeveloperPaused{
    return [[CVSDKBridgingWeb3 shared] isDeveloperPaused:chainverseFactoryAddress developerAddress:[ChainverseSDK shared].developerAddress];
}

- (NSString *)buyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [[CVSDKBridgingWeb3 shared] buyNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] currency:currency listingId:listingId price:price];
}

- (NSString *)feeBuyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [[CVSDKBridgingWeb3 shared] feeBuyNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] currency:currency listingId:listingId price:price];
}

- (NSString *)bidNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    return [[CVSDKBridgingWeb3 shared] bidNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] currency:currency listingId:listingId price:price];
}

- (NSString *)approveToken:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount{
    return [[CVSDKBridgingWeb3 shared] approveToken:[CVSDKUserDefault getXUserAdress] token:token spender:spender amount:amount];
}

- (NSString *)feeApproveToken:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount{
    return [[CVSDKBridgingWeb3 shared] feeApproveToken:[CVSDKUserDefault getXUserAdress] token:token spender:spender amount:amount];
}
- (NSString *)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    return [[CVSDKBridgingWeb3 shared] sellNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] nft:NFT tokenId:tokenId price:price currency:currency];
}

- (NSString *)feeSellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    return [[CVSDKBridgingWeb3 shared] feeSellNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] nft:NFT tokenId:tokenId price:price currency:currency];
}

- (NSString *)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] approveNFT:marketServiceAddress abi:ABI_ERC721 walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
}

- (NSString *)feeApproveNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] feeApproveNFT:marketServiceAddress abi:ABI_ERC721 walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
}

- (NSString *)approveNFTForGame:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] approveNFT:[ChainverseSDK shared].gameAddress abi:ABI_ERC721 walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
}

- (NSString *)approveNFTForService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] approveNFT:service abi:abi walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
}

- (NSString *)cancelSellNFT: (NSInteger )listingId{
    return [[CVSDKBridgingWeb3 shared] cancelSellNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] listing:listingId];
}

- (NSString *)feeCancelSellNFT: (NSInteger )listingId{
    return [[CVSDKBridgingWeb3 shared] feeCancelSellNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] listing:listingId];
}


- (void)getNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKGetNFTBlock) complete{
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.chainverse.getnft", NULL);
    dispatch_async(backgroundQueue, ^{
        PMKJoin(@[[self getDetailNFT:nft tokenId:tokenId],[self getByNFT:nft tokenId:tokenId]]).then(^(id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self doGetNFT:responseObject complete:complete];
            });
        }).catch(^(NSError *error){

        });
    });
}

- (void)doGetNFT:(id) responseObject complete:(CVSDKGetNFTBlock) complete{
    if([responseObject count] == 2){
        CVSDKTokenURI *respone  = (CVSDKTokenURI *)[responseObject objectAtIndex:0];
        NSDictionary *itemDict = (NSDictionary *)[responseObject objectAtIndex:1];
        
        Auction *auction = [[Auction alloc] init];
        NSString *listingId = [[itemDict allKeys] containsObject:@"listing_id"] ? [NSString stringWithFormat:@"%@",[itemDict objectForKey:@"listing_id"]] : @"0";
        NSString *price = [[itemDict allKeys] containsObject:@"price"] ? [NSString stringWithFormat:@"%@",[itemDict objectForKey:@"price"]] : @"0";
        auction.listing_id = listingId;
        auction.price = price;
        auction.is_auction = [[itemDict allKeys] containsObject:@"is_ended"] ? [itemDict objectForKey:@"is_ended"] : false;
        
        InfoSell *infoSell = [[InfoSell alloc] init];
        infoSell.listing_id = auction.listing_id;
        infoSell.price = auction.price;
        infoSell.is_auction = auction.is_auction;
        infoSell.currency_info = auction.currency_info;
        NSMutableArray<Auction> *auctions = [NSMutableArray<Auction> array] ;
        
        [auctions addObject:auction];
        
        NFT *item = [[NFT alloc] init];
        NSString *tokenId = [[itemDict allKeys] containsObject:@"token_id"] ? [NSString stringWithFormat:@"%@",[itemDict objectForKey:@"token_id"]] : @"0";
        item.ownerOnChain = @"";
        item.token_id = tokenId;
        item.owner = [[itemDict allKeys] containsObject:@"owner"] ? [itemDict objectForKey:@"owner"] : @"";
        item.nft = [[itemDict allKeys] containsObject:@"nft"] ? [itemDict objectForKey:@"nft"] : @"";
        item.image = respone.image ? respone.image : @"";
        item.image_preview = respone.image ? respone.image : @"";
        item.name = respone.name ? respone.name : @"";
        item.attributes = respone.attributes ? [NSString stringWithFormat:@"%@",respone.attributes] : @"";
        item.auctions = auctions;
        item.infoSell = infoSell;
        complete(item);
    }

}

- (AnyPromise *)getByNFT:(NSString *)nft tokenId:(NSInteger )tokenId
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSMutableDictionary *dicNFT = [[CVSDKBridgingWeb3 shared] getByNFT:marketServiceAddress abi:ABI_MarketService nft:nft tokenId:tokenId];
        resolve(dicNFT);
    }];
}

- (AnyPromise *)getDetailNFT:(NSString *)nft tokenId:(NSInteger )tokenId
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSString *tokenUri = [[CVSDKBridgingWeb3 shared] getTokenUri:nft tokenId:tokenId];
        
        [[CVSDKRESTfulClient marketShared] getDetailNFT:tokenUri  completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            CVSDKTokenURI *item = [CVSDKParseJson parseTokenUri:responseObject];
            resolve(item);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }];
}

- (NSString *)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] isApproved:nft tokenId:tokenId];
}

- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner spender:(NSString *)spender{
    return [[CVSDKBridgingWeb3 shared] isApproved:token owner:owner spender:spender];
}
- (NSString *)transferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] transferItem:[CVSDKUserDefault getXUserAdress] to:to nft:nft tokenId:tokenId];
}


- (NSString *)feeTransferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] feeTransferItem:[CVSDKUserDefault getXUserAdress] to:to nft:nft tokenId:tokenId];
}

- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] withdrawNFT:[CVSDKUserDefault getXUserAdress] gameAddress:[ChainverseSDK shared].gameAddress abi:ABI_Game nft:nft tokenId:tokenId];
}

- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] moveService:[CVSDKUserDefault getXUserAdress] serviceAddress:[ChainverseSDK shared].gameAddress abi:ABI_Game nft:nft tokenId:tokenId];
}

- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] moveService:[CVSDKUserDefault getXUserAdress] serviceAddress:service abi:abi nft:nft tokenId:tokenId];
}

//Chainverse App
- (void)approveNFTWithChainverseApp:(NSString *)nft tokenId:(NSInteger )tokenId{
    [[CVSDKBridgingWeb3 shared] approveNFTWithChainverseApp:marketServiceAddress abi:ABI_ERC721 walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
}

- (void)approveTokenWithChainverseApp:(NSString *)token spender:(NSString *)spender amount:(NSString *)amount{
    [[CVSDKBridgingWeb3 shared] approveTokenWithChainverseApp:[CVSDKUserDefault getXUserAdress] token:token spender:spender amount:amount];
}

- (void)buyNFTWithChainverseApp:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    [[CVSDKBridgingWeb3 shared] buyNFTWithChainverseApp:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] currency:currency listingId:listingId price:price];
}

- (void)sellNFTWithChainverseApp:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    [[CVSDKBridgingWeb3 shared] sellNFTWithChainverseApp:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] nft:NFT tokenId:tokenId price:price currency:currency];
}

- (void)cancelSellNFTWithChainverseApp: (NSInteger )listingId{
    [[CVSDKBridgingWeb3 shared] cancelSellNFTWithChainverseApp:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] listing:listingId];
}
@end
