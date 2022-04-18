//
//  CVTNFT.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"
#import "ChainverseNFTAuction.h"
#import "ChainverseNFTType.h"
#import "ChainverseNFTNetwork.h"
#import "ChainverseNFTCategory.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFT

@end
@interface ChainverseNFT : JSONModel
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSString *token_id;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *nft;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *image_preview;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *attributes;
@property (nonatomic, strong) NSArray<ChainverseNFTAuction> *auctions;
@property (nonatomic, strong) ChainverseNFTType *type;
@property (nonatomic, strong) ChainverseNFTNetwork *network_info;
//@property (nonatomic, strong) NSArray<ChainverseNFTCategory> *categories;

@end

NS_ASSUME_NONNULL_END
