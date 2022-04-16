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
#import "CVSDKServiceManager.h"
#import "CVSDKService.h"
#import "CVSDKRESTfulClient.h"
#import "CVSDKParseJson.h"
#import "ChainverseNFT.h"
#import "ChainverseNFTAuction.h"
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

- (NSString *)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    return [[CVSDKBridgingWeb3 shared] sellNFT:marketServiceAddress abi:ABI_MarketService walletAddress:[CVSDKUserDefault getXUserAdress] nft:NFT tokenId:tokenId price:price currency:currency];
}

- (NSString *)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] approveNFT:marketServiceAddress abi:ABI_ERC721 walletAddress:[CVSDKUserDefault getXUserAdress] nft:nft tokenId:tokenId];
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
        
        ChainverseNFTAuction *auction = [[ChainverseNFTAuction alloc] init];
        auction.listing_id = [[itemDict allKeys] containsObject:@"listing_id"] ? [itemDict objectForKey:@"listing_id"] : 0;
        auction.price = [[itemDict allKeys] containsObject:@"price"] ? [itemDict objectForKey:@"price"] : @"";
        auction.is_auction = [[itemDict allKeys] containsObject:@"is_ended"] ? [itemDict objectForKey:@"is_ended"] : false;
        
        NSArray<ChainverseNFTAuction> *auctions;
        [auctions arrayByAddingObject:auction];
        
        ChainverseNFT *item = [[ChainverseNFT alloc] init];
        item.token_id = [[itemDict allKeys] containsObject:@"token_id"] ? [itemDict objectForKey:@"token_id"] : 0;
        item.owner = [[itemDict allKeys] containsObject:@"owner"] ? [itemDict objectForKey:@"owner"] : @"";
        item.nft = [[itemDict allKeys] containsObject:@"nft"] ? [itemDict objectForKey:@"nft"] : @"";
        item.image = respone.image ? respone.image : @"";
        item.image_preview = respone.image ? respone.image : @"";
        item.name = respone.name ? respone.name : @"";
        item.attributes = respone.attributes ? respone.attributes : @"";
        item.auctions = auctions;
        
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

- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] withdrawNFT:[CVSDKUserDefault getXUserAdress] gameAddress:[ChainverseSDK shared].gameAddress abi:ABI_Game nft:nft tokenId:tokenId];
}

- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] moveService:[CVSDKUserDefault getXUserAdress] serviceAddress:[ChainverseSDK shared].gameAddress abi:ABI_Game nft:nft tokenId:tokenId];
}

- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    return [[CVSDKBridgingWeb3 shared] moveService:[CVSDKUserDefault getXUserAdress] serviceAddress:service abi:abi nft:nft tokenId:tokenId];
}
@end
