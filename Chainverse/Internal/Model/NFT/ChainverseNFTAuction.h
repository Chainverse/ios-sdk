//
//  CVTNFTAuctions.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"
#import "ChainverseNFTCurrency.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFTAuction

@end
@interface ChainverseNFTAuction : JSONModel
@property (nonatomic, strong) NSString *listing_id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic) BOOL is_auction;
@property (nonatomic, strong) ChainverseNFTCurrency *currency_info;
@end

NS_ASSUME_NONNULL_END
