//
//  CVTNFTCurrency.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFTCurrency

@end
@interface ChainverseNFTCurrency : JSONModel
@property (nonatomic, strong) NSString *currency;
@property (nonatomic) NSInteger decimal;
@property (nonatomic, strong) NSString *symbol;
@end

NS_ASSUME_NONNULL_END
