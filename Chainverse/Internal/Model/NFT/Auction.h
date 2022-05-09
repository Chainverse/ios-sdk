//
//  Auction.h
//  Chainverse-SDK
//
//  Created by pham nam on 06/05/2022.
//

#import "JSONModel.h"
#import "Currency.h"
NS_ASSUME_NONNULL_BEGIN
@protocol Auction

@end
@interface Auction : JSONModel
@property (nonatomic, strong) NSString *listing_id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic) BOOL is_auction;
@property (nonatomic, strong) Currency *currency_info;
@end

NS_ASSUME_NONNULL_END
