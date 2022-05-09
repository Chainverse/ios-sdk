//
//  NFT.h
//  Chainverse-SDK
//
//  Created by pham nam on 06/05/2022.
//

#import "JSONModel.h"
#import "InfoSell.h"
#import "Auction.h"
#import "Type.h"
#import "Categories.h"
#import "Network.h"
NS_ASSUME_NONNULL_BEGIN
@protocol NFT

@end
@interface NFT : JSONModel
@property (nonatomic, strong) NSString *token_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nft;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *ownerOnChain;
@property (nonatomic, strong) NSString *attributes;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *image_preview;
@property (nonatomic, strong) InfoSell *infoSell;
@property (nonatomic, strong) Type *type;
@property (nonatomic, strong) NSMutableArray<Categories> *categories;
@property (nonatomic, strong) Network *network_info;
@property (nonatomic, strong) NSMutableArray<Auction> *auctions;
@end

NS_ASSUME_NONNULL_END
